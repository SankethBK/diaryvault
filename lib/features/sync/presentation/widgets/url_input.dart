import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:flutter/material.dart';

class URLInput extends StatelessWidget {
  final String? Function() getErrors;
  final void Function(String email) onChaged;
  final bool autoFocus;
  final String hintText;

  const URLInput({
    Key? key,
    required this.getErrors,
    required this.onChaged,
    required this.hintText,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.errorTextColor;
    final prefixIconColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.prefixIconColor;

    final hintTextColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.hintTextColor;

    final textColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.textColor;

    final borderColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.borderColor;

    final fillColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.fillColor;
    return Stack(
      children: [
        TextField(
          autofocus: autoFocus,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: hintTextColor),
            prefixIcon: Icon(
              Icons.link,
              color: prefixIconColor,
            ),
            fillColor: fillColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: borderColor,
                width: 0.7,
              ),
            ),
            errorText: getErrors(),
            errorStyle: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onChanged: onChaged,
        ),
      ],
    );
  }
}
