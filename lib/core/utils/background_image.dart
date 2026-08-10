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
