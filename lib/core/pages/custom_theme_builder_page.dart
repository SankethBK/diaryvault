import 'dart:io';

import 'package:dairy_app/app/themes/custom_theme/custom_theme_config.dart';
import 'package:dairy_app/app/themes/custom_theme/palette_extractor.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/presentation/bloc/theme/theme_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

final log = printer("CustomThemeBuilderPage");

class CustomThemeBuilderPage extends StatefulWidget {
  /// When provided, the page edits this theme instead of creating a new one
  final CustomThemeConfig? existing;

  const CustomThemeBuilderPage({Key? key, this.existing}) : super(key: key);

  @override
  State<CustomThemeBuilderPage> createState() => _CustomThemeBuilderPageState();
}

class _CustomThemeBuilderPageState extends State<CustomThemeBuilderPage> {
  String? _imagePath;
  Color? _backgroundColor;
  bool _isDark = true;
  Color? _accentColor;
  Color? _mutedColor;
  bool _isProcessing = false;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    final existing = widget.existing;
    _nameController = TextEditingController(text: existing?.name ?? '');
    if (existing != null) {
      _imagePath = existing.backgroundImagePath;
      _backgroundColor = existing.backgroundColor;
      _isDark = existing.isDark;
      _accentColor = existing.accentColor;
      _mutedColor = existing.mutedColor;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    // FileType.custom forces the document picker (Files app) instead of the
    // photo picker, so users can also browse Downloads/Drive and it works
    // on emulators with an empty media store
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'gif'],
    );
    final pickedPath = result?.files.single.path;
    if (pickedPath == null) return;

    setState(() => _isProcessing = true);

    try {
      // copy into app documents so the image survives cache cleanups.
      // unique filename per pick: multiple themes need distinct files, and
      // reusing a path would make Flutter's image cache serve stale bytes
      final docsDir = await getApplicationDocumentsDirectory();
      final extension = pickedPath.split('.').last;
      final savedPath =
          '${docsDir.path}/custom_theme_${const Uuid().v4()}.$extension';
      await File(pickedPath).copy(savedPath);

      final palette = await extractPaletteFromImage(savedPath);

      setState(() {
        _imagePath = savedPath;
        _backgroundColor = null;
        _accentColor = palette.accent;
        _mutedColor = palette.muted;
      });
    } catch (e) {
      log.e("failed to process custom theme image: $e");
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  /// Lets the user pick a solid background color instead of an image, and
  /// derives starter accent/muted colors from it (user can edit them after)
  Future<void> _pickBackgroundColor() async {
    final color = await _showColorPicker(
        _backgroundColor ?? (_isDark ? Colors.black : Colors.white));
    if (color == null) return;

    final hsv = HSVColor.fromColor(color);
    final isDarkColor = color.computeLuminance() < 0.4;

    final accent = hsv
        .withHue((hsv.hue + 30) % 360)
        .withSaturation(0.75)
        .withValue(0.9)
        .toColor();
    final muted = hsv
        .withSaturation((hsv.saturation * 0.4).clamp(0.0, 1.0))
        .withValue(
            (hsv.value * (isDarkColor ? 1.6 : 0.55)).clamp(0.0, 1.0))
        .toColor();

    setState(() {
      _imagePath = null;
      _backgroundColor = color;
      _isDark = isDarkColor;
      _accentColor = accent;
      _mutedColor = muted;
    });
  }

  Future<void> _editColor({required bool isAccent}) async {
    final current = (isAccent ? _accentColor : _mutedColor) ?? Colors.grey;
    final color = await _showColorPicker(current);
    if (color == null) return;

    setState(() {
      if (isAccent) {
        _accentColor = color;
      } else {
        _mutedColor = color;
      }
    });
  }

  Future<Color?> _showColorPicker(Color initial) async {
    Color picked = initial;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.current.pickAColor),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: initial,
            onColorChanged: (color) => picked = color,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(S.current.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(S.current.select),
          ),
        ],
      ),
    );

    return confirmed == true ? picked : null;
  }

  Future<void> _applyTheme() async {
    final hasBackground = _imagePath != null || _backgroundColor != null;
    if (!hasBackground || _accentColor == null || _mutedColor == null) {
      return;
    }

    // clean up the old image file when it was replaced or dropped
    final oldImagePath = widget.existing?.backgroundImagePath;
    if (oldImagePath != null && oldImagePath != _imagePath) {
      try {
        await File(oldImagePath).delete();
      } catch (e) {
        log.w("could not delete replaced theme image: $e");
      }
    }

    final config = CustomThemeConfig(
      id: widget.existing?.id ?? const Uuid().v4(),
      name: _nameController.text.trim().isEmpty
          ? S.current.defaultThemeName
          : _nameController.text.trim(),
      backgroundImagePath: _imagePath,
      backgroundColorValue: _backgroundColor?.toARGB32(),
      isDark: _isDark,
      accentColorValue: _accentColor!.toARGB32(),
      mutedColorValue: _mutedColor!.toARGB32(),
    );

    await context.read<ThemeCubit>().saveCustomTheme(config);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final overlay = _isDark ? Colors.black : Colors.white;
    final textColor = _isDark ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing == null ? S.current.createYourTheme : S.current.editTheme),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: _backgroundColor ?? overlay,
          image: _imagePath != null
              ? DecorationImage(
                  image: FileImage(File(_imagePath!)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: overlay.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.current.customThemeIntro,
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _isProcessing ? null : _pickImage,
                  icon: const Icon(Icons.photo_library),
                  label: Text(_imagePath == null
                      ? S.current.chooseBackgroundImage
                      : S.current.changeImage),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: _isProcessing ? null : _pickBackgroundColor,
                  icon: const Icon(Icons.format_color_fill),
                  label: Text(_backgroundColor == null
                      ? S.current.pickBackgroundColorInstead
                      : S.current.changeBackgroundColor),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: S.current.themeName,
                    labelStyle:
                        TextStyle(color: textColor.withValues(alpha: 0.7)),
                    hintText: S.current.themeNameHint,
                    hintStyle:
                        TextStyle(color: textColor.withValues(alpha: 0.4)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: textColor.withValues(alpha: 0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _accentColor ?? textColor),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_isProcessing)
                  const Center(child: CircularProgressIndicator())
                else if (_accentColor != null && _mutedColor != null) ...[
                  Text(
                    S.current.paletteInstruction,
                    style: TextStyle(color: textColor, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _editColor(isAccent: true),
                        child: _swatch(_accentColor!, S.current.accent),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _editColor(isAccent: false),
                        child: _swatch(_mutedColor!, S.current.muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.current.darkTheme,
                          style: TextStyle(color: textColor, fontSize: 16)),
                      Switch(
                        value: _isDark,
                        onChanged: (value) => setState(() => _isDark = value),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _applyTheme,
                    child: Text(widget.existing == null
                        ? S.current.saveAndApplyTheme
                        : S.current.saveChanges),
                  ),
                ] else
                  Expanded(
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 80,
                        color: textColor.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _swatch(Color color, String label) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: (_isDark ? Colors.white : Colors.black87)
                .withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
