import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../flutter_quill_extensions.dart';

class AudioButton extends StatelessWidget {
  const AudioButton({
    required this.icon,
    required this.audioPickSetting,
    required this.controller,
    this.fillColor,
    this.tooltip,
    this.iconTheme,
    this.onAudioPickCallback,
    this.iconSize = kDefaultIconSize,
  });

  final IconData icon;
  final double iconSize;
  final Color? fillColor;
  final String? tooltip;
  final QuillIconTheme? iconTheme;
  final OnAudioPickCallback? onAudioPickCallback;
  final AudioPickSettingSelector? audioPickSetting;
  final QuillController controller;

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
    if (audioPickSetting != null) {
      final filePath = await audioPickSetting!(context);

      if (filePath != null && filePath.isNotEmpty) {
        final index = controller.selection.baseOffset;
        final length = controller.selection.extentOffset - index;

        controller.replaceText(index, length, BlockEmbed.audio(filePath), null);

        if (onAudioPickCallback != null) {
          await onAudioPickCallback!(filePath);
        }
      }
    }
  }
}
