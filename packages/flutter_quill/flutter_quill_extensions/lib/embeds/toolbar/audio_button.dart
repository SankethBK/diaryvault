import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../flutter_quill_extensions.dart';

class AudioButton extends StatelessWidget {
  const AudioButton({
    required this.icon,
    required this.audioPickSetting,
    this.fillColor,
    this.tooltip,
    this.iconTheme,
    this.iconSize = kDefaultIconSize,
    this.onAudioPickCallback,
  });

  final IconData icon;
  final double iconSize;
  final Color? fillColor;
  final String? tooltip;
  final QuillIconTheme? iconTheme;
  final OnAudioPickCallback? onAudioPickCallback;
  final AudioPickSettingSelector? audioPickSetting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final iconColor = iconTheme?.iconUnselectedColor ?? theme.iconTheme.color;
    final iconFillColor =
        iconTheme?.iconUnselectedFillColor ?? (fillColor ?? theme.canvasColor);
    return QuillIconButton(
      icon: Icon(icon, size: iconSize, color: iconColor),
      tooltip: tooltip,
      highlightElevation: 0,
      hoverElevation: 0,
      size: iconSize * 1.77,
      fillColor: iconFillColor,
      borderRadius: iconTheme?.borderRadius ?? 2,
      onPressed: () => _onPressedHandler(context),
    );
  }

  Future<void> _onPressedHandler(BuildContext context) async {
    print('on pressed handler called');

    if (audioPickSetting != null) {
      final result = await audioPickSetting!(context);
      print('user selected $result');

      if (result == AudioPickSetting.File) {
        final path = await FilePicker.platform.pickFiles(
          type: FileType.audio,
        );

        print('path = $path');
      } else if (result == AudioPickSetting.Record) {}
    }
  }
}
