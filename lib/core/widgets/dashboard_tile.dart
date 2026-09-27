import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:flutter/material.dart';

/// Shared themed tile used by dashboard panes.
class DashboardTile extends StatelessWidget {
  const DashboardTile({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.subtitle,
    this.onTap,
    this.titleColor,
    this.subtitleColor,
  });

  final IconData icon;
  final String label;
  final Color color;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                homeTheme.notePreviewUnselectedGradientStartColor,
                homeTheme.notePreviewUnselectedGradientEndColor,
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            border: Border.all(color: homeTheme.notePreviewBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 23),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: titleColor ?? homeTheme.previewTitleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: subtitleColor ?? homeTheme.previewBodyColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
