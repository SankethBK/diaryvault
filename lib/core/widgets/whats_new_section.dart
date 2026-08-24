import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class WhatsNewSection extends StatefulWidget {
  const WhatsNewSection({Key? key}) : super(key: key);

  @override
  State<WhatsNewSection> createState() => _WhatsNewSectionState();
}

class _WhatsNewSectionState extends State<WhatsNewSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return Column(
      children: [
        SettingsTile(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Row(
            children: [
              Text(
                S.current.whatsNew,
                style: TextStyle(fontSize: 16, color: mainTextColor),
              ),
              const Spacer(),
              Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: mainTextColor,
              ),
            ],
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 6),
          SettingsTile(
            height: 64,
            child: _UpdateTile(
              title: S.current.whatsNewThemesTitle,
              subtitle: S.current.whatsNewThemesSubtitle,
              color: mainTextColor,
            ),
          ),
          const SizedBox(height: 6),
          SettingsTile(
            height: 64,
            child: _UpdateTile(
              title: S.current.whatsNewEncryptionTitle,
              subtitle: S.current.whatsNewEncryptionSubtitle,
              color: mainTextColor,
            ),
          ),
        ],
      ],
    );
  }
}

class _UpdateTile extends StatelessWidget {
  const _UpdateTile({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, color: color),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.8)),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
