import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:simple_accordion/widgets/AccordionHeaderItem.dart';
import 'package:simple_accordion/widgets/AccordionItem.dart';
import 'package:simple_accordion/widgets/AccordionWidget.dart';

class ExportNotes extends StatelessWidget {
  const ExportNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return SimpleAccordion(
        headerColor: mainTextColor,
        headerTextStyle: TextStyle(
          color: mainTextColor,
          fontSize: 16,
        ),
        children: [
          AccordionHeaderItem(
            title: S.current.exportNotes,
            children: [
              AccordionItem(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: SettingsTile(
                          child: Text(
                            S.current.exportToPlainText,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: mainTextColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Material(
                        color: Colors.transparent,
                        child: SettingsTile(
                          child: Text(
                            S.current.exportToPDF,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: mainTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ]);
  }
}
