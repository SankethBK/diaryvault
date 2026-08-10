import 'dart:io';

import 'package:dairy_app/app/themes/custom_theme/custom_theme_config.dart';
import 'package:dairy_app/app/themes/custom_theme/palette_extractor.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/presentation/bloc/theme/theme_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        _accentColor = palette.accent;
        _mutedColor = palette.muted;
      });
    } catch (e) {
      log.e("failed to process custom theme image: $e");
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _applyTheme() async {
    if (_imagePath == null || _accentColor == null || _mutedColor == null) {
      return;
    }

    final config = CustomThemeConfig(
      id: widget.existing?.id ?? const Uuid().v4(),
      name: _nameController.text.trim().isEmpty
          ? 'My Theme'
          : _nameController.text.trim(),
      backgroundImagePath: _imagePath!,
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
        title: Text(widget.existing == null ? "Create your theme" : "Edit theme"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: overlay,
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
                  "Pick a photo you love, and we'll build a theme from its colors.",
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _isProcessing ? null : _pickImage,
                  icon: const Icon(Icons.photo_library),
                  label: Text(_imagePath == null
                      ? "Choose background image"
                      : "Change image"),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: "Theme name",
                    labelStyle:
                        TextStyle(color: textColor.withValues(alpha: 0.7)),
                    hintText: "My Theme",
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
                    "Extracted palette",
                    style: TextStyle(color: textColor, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _swatch(_accentColor!, "Accent"),
                      const SizedBox(width: 12),
                      _swatch(_mutedColor!, "Muted"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dark theme",
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
                        ? "Save & apply theme"
                        : "Save changes"),
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
