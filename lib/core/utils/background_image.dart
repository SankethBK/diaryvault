import 'dart:io';

import 'package:flutter/material.dart';

/// Returns the appropriate [ImageProvider] for a theme background image path.
///
/// Bundled theme backgrounds are asset paths ("assets/...") while custom
/// theme backgrounds are absolute file paths on disk.
ImageProvider getBackgroundImageProvider(String path) {
  if (path.startsWith('assets/')) {
    return AssetImage(path);
  }
  return FileImage(File(path));
}

/// Builds the page background [BoxDecoration] for a theme.
///
/// Shows [backgroundColor] (falling back to [fallbackColor]) as the base
/// color, and layers the background image on top when [imagePath] is set.
/// For solid-color themes [imagePath] is null and only the color is shown.
BoxDecoration getBackgroundDecoration(
  String? imagePath, {
  Color? backgroundColor,
  Color? fallbackColor,
}) {
  return BoxDecoration(
    color: backgroundColor ?? fallbackColor,
    image: imagePath != null
        ? DecorationImage(
            image: getBackgroundImageProvider(imagePath),
            fit: BoxFit.cover,
          )
        : null,
  );
}
