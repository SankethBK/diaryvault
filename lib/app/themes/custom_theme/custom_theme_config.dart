import 'dart:convert';

import 'package:flutter/material.dart';

/// Persisted configuration for a user-generated custom theme.
///
/// Built by picking a background image and extracting a small palette
/// from it. Stored as JSON in the key-value data source.
class CustomThemeConfig {
  /// Stable identifier, also used to reference saved themes in the list
  final String id;

  /// User-facing name of the theme
  final String name;

  /// Absolute file path of the background image (copied into app documents dir)
  final String backgroundImagePath;

  /// Whether the theme is a dark or light variant
  final bool isDark;

  /// Main accent color (buttons, links, highlights) extracted from the image
  final int accentColorValue;

  /// Deeper/muted color extracted from the image, used for panels and fills
  final int mutedColorValue;

  const CustomThemeConfig({
    required this.id,
    required this.name,
    required this.backgroundImagePath,
    required this.isDark,
    required this.accentColorValue,
    required this.mutedColorValue,
  });

  Color get accentColor => Color(accentColorValue);
  Color get mutedColor => Color(mutedColorValue);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'backgroundImagePath': backgroundImagePath,
        'isDark': isDark,
        'accentColorValue': accentColorValue,
        'mutedColorValue': mutedColorValue,
      };

  factory CustomThemeConfig.fromJson(Map<String, dynamic> json) {
    return CustomThemeConfig(
      // legacy configs (pre multi-theme) have no id/name
      id: json['id'] as String? ?? json['backgroundImagePath'] as String,
      name: json['name'] as String? ?? 'My Theme',
      backgroundImagePath: json['backgroundImagePath'] as String,
      isDark: json['isDark'] as bool,
      accentColorValue: json['accentColorValue'] as int,
      mutedColorValue: json['mutedColorValue'] as int,
    );
  }

  String encode() => jsonEncode(toJson());

  static CustomThemeConfig? tryDecode(String? encoded) {
    if (encoded == null || encoded.isEmpty) return null;
    try {
      return CustomThemeConfig.fromJson(
          jsonDecode(encoded) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }
}
