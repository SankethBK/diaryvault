import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class NoteTitleInputField extends StatefulWidget {
  // final String? Function() getEmailErrors;
  final void Function(String email) onTitleChanged;
  final String initialValue;
  const NoteTitleInputField({
    Key? key,
    // required this.getEmailErrors,
    required this.initialValue,
    required this.onTitleChanged,
  }) : super(key: key);

  @override
  State<NoteTitleInputField> createState() => _NoteTitleInputFieldState();
}

class _NoteTitleInputFieldState extends State<NoteTitleInputField> {
  bool showTitleInput = true;

  @override
  Widget build(BuildContext context) {
    final textInputBorderRadius = BorderRadius.circular(15.0);

    final titleTextBoxFillColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .titleTextBoxFillColor;

    final titleTextBoxBorderColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .titleTextBoxBorderColor;

    final titleTextBoxFocussedBorderColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .titleTextBoxFocussedBorderColor;

    final titlePlaceHolderColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .titlePlaceHolderColor;

    final titleTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .titleTextColor;

    final suffixIconColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .suffixIconColor;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showTitleInput
          ? GlassMorphismCover(
              borderRadius: textInputBorderRadius,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                        color: titleTextColor, fontWeight: FontWeight.w500),
                    initialValue: widget.initialValue,
                    decoration: InputDecoration(
                      hintText: "title",
                      hintStyle: TextStyle(
                          color: titlePlaceHolderColor,
                          fontWeight: FontWeight.normal),
                      fillColor: titleTextBoxFillColor,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: textInputBorderRadius,
                        borderSide: BorderSide(
                          color: titleTextBoxFocussedBorderColor,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: textInputBorderRadius,
                        borderSide: BorderSide(
                          color: titleTextBoxBorderColor,
                          width: 0.5,
                        ),
                      ),
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.arrow_upward,
                          color: suffixIconColor,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            showTitleInput = false;
                          });
                        },
                      ),
                    ),
                    onChanged: widget.onTitleChanged,
                  ),
                  const SizedBox(height: 10),
                ],
              ))
          : Column(
              children: [
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showTitleInput = true;
                    });
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: suffixIconColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_downward,
                          size: 15,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        S.current.tapToExpandTitle,
                        style: TextStyle(
                          color: suffixIconColor,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
    );
  }
}
