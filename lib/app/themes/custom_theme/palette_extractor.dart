import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

final log = printer("PaletteExtractor");

/// Extracts a small palette (accent + muted colors) from an image file.
Future<({Color accent, Color muted})> extractPaletteFromImage(
    String imagePath) async {
  try {
    final generator = await PaletteGenerator.fromImageProvider(
      FileImage(File(imagePath)),
      maximumColorCount: 20,
    );

    final accent = generator.vibrantColor?.color ??
        generator.lightVibrantColor?.color ??
        generator.dominantColor?.color ??
        Colors.teal;

    final muted = generator.darkMutedColor?.color ??
        generator.mutedColor?.color ??
        generator.darkVibrantColor?.color ??
        generator.dominantColor?.color ??
        Colors.blueGrey;

    return (accent: accent, muted: muted);
  } catch (e) {
    log.e("palette extraction failed: $e");
    return (accent: Colors.teal, muted: Colors.blueGrey);
  }
}
