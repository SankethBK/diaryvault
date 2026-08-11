import 'dart:io';

import 'package:dairy_app/app/themes/custom_theme/custom_theme_config.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/pages/custom_theme_builder_page.dart';
import 'package:dairy_app/features/auth/presentation/bloc/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final log = printer("CustomThemesSection");

/// Lists all saved custom themes and provides an entry point to the
/// custom theme builder. Shown in the "Themes, Fonts & Language" settings.
class CustomThemesSection extends StatelessWidget {
  const CustomThemesSection({Key? key}) : super(key: key);

  Future<void> _deleteTheme(
      BuildContext context, CustomThemeConfig config) async {
    // best effort cleanup of the background image file
    try {
      final imagePath = config.backgroundImagePath;
      if (imagePath != null) {
        await File(imagePath).delete();
      }
    } catch (e) {
      log.w("could not delete custom theme image: $e");
    }

    if (context.mounted) {
      await context.read<ThemeCubit>().deleteCustomTheme(config.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: BlocProvider.of<ThemeCubit>(context),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Custom themes",
                  style: TextStyle(fontSize: 16.0, color: mainTextColor),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CustomThemeBuilderPage(),
                    ),
                  ),
                  icon: Icon(Icons.add, color: mainTextColor),
                  label: Text(
                    "Create",
                    style: TextStyle(color: mainTextColor),
                  ),
                ),
              ],
            ),
            if (state.customThemes.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "Build a theme from your own photo",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: mainTextColor.withValues(alpha: 0.6),
                  ),
                ),
              )
            else
              ...state.customThemes.map((config) {
                final isActive = state.theme == Themes.custom &&
                    state.customConfig?.id == config.id;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: _themePreview(config),
                  title: Text(
                    config.name,
                    style: TextStyle(color: mainTextColor),
                  ),
                  subtitle: Text(
                    config.isDark ? "Dark" : "Light",
                    style: TextStyle(
                      color: mainTextColor.withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isActive)
                        Icon(Icons.check_circle, color: config.accentColor),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: mainTextColor.withValues(alpha: 0.7),
                        ),
                        onPressed: () => _deleteTheme(context, config),
                      ),
                    ],
                  ),
                  onTap: () =>
                      context.read<ThemeCubit>().applyCustomTheme(config),
                  onLongPress: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          CustomThemeBuilderPage(existing: config),
                    ),
                  ),
                );
              }),
          ],
        );
      },
    );
  }

  Widget _themePreview(CustomThemeConfig config) {
    final imagePath = config.backgroundImagePath;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: imagePath == null ? config.backgroundColor : null,
        image: imagePath != null
            ? DecorationImage(
                image: FileImage(File(imagePath)),
                fit: BoxFit.cover,
              )
            : null,
        border: Border.all(color: config.accentColor, width: 2),
      ),
    );
  }
}
