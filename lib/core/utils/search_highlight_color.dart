import 'package:flutter/material.dart';

/// Keeps search highlights consistent while lifting very dark theme colors.
Color searchHighlightColor(BuildContext context) {
  final color = Theme.of(context).colorScheme.primaryContainer;
  if (color.computeLuminance() < 0.25) {
    return Color.lerp(color, Colors.white, 0.25)!;
  }
  return color;
}
