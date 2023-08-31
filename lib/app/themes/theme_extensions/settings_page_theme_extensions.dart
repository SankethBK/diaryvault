import 'package:flutter/material.dart';

class SettingsPageThemeExtensions
    extends ThemeExtension<SettingsPageThemeExtensions> {
  // SwitchListTile settings
  final Color? inactiveTrackColor;
  final Color? activeColor;
  final Color? syncButtonColor;
  final Color? dropDownBackgroundColor;

  SettingsPageThemeExtensions({
    required this.inactiveTrackColor,
    required this.activeColor,
    required this.syncButtonColor,
    required this.dropDownBackgroundColor,
  });

  @override
  ThemeExtension<SettingsPageThemeExtensions> copyWith({
    Color? inactiveTrackColor,
    Color? activeColor,
    Color? syncButtonColor,
    Color? dropDownBackgroundColor,
  }) {
    return SettingsPageThemeExtensions(
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      activeColor: activeColor ?? this.activeColor,
      syncButtonColor: syncButtonColor ?? this.syncButtonColor,
      dropDownBackgroundColor:
          dropDownBackgroundColor ?? this.dropDownBackgroundColor,
    );
  }

  @override
  ThemeExtension<SettingsPageThemeExtensions> lerp(
      covariant SettingsPageThemeExtensions? other, double t) {
    return SettingsPageThemeExtensions(
      inactiveTrackColor:
          Color.lerp(inactiveTrackColor, other?.inactiveTrackColor, t)!,
      activeColor: Color.lerp(activeColor, other?.activeColor, t)!,
      syncButtonColor: Color.lerp(syncButtonColor, other?.syncButtonColor, t)!,
      dropDownBackgroundColor: Color.lerp(
          dropDownBackgroundColor, other?.dropDownBackgroundColor, t)!,
    );
  }
}
