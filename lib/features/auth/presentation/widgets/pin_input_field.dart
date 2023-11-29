import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AuthPinInput extends StatefulWidget {
  final String? Function() getPinErrors;
  final void Function(String pin) onPinChanged;
  final bool autoFocus;
  final String hintText;
  const AuthPinInput({
    Key? key,
    required this.getPinErrors,
    required this.onPinChanged,
    this.autoFocus = false,
    this.hintText = "pin",
  }) : super(key: key);

  @override
  State<AuthPinInput> createState() => _AuthPinInputState();
}

class _AuthPinInputState extends State<AuthPinInput> {
  bool _pinVisibility = true;

  void _togglePinVisibility() => setState(() {
    _pinVisibility = !_pinVisibility;
  });

  @override
  Widget build(BuildContext context) {
    final errorColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.linkColor;

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
          autofocus: widget.autoFocus,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: hintTextColor),
            prefixIcon: Icon(
              Icons.lock,
              color: prefixIconColor,
            ),
            suffixIcon: InkWell(
              onTap: _togglePinVisibility,
              child: Icon(
                !_pinVisibility ? Icons.visibility : Icons.visibility_off,
                color: prefixIconColor,
              ),
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
            errorText: widget.getPinErrors(),
            errorStyle: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
          ),
          obscureText: _pinVisibility,
          onChanged: widget.onPinChanged,
        ),
      ],
    );
  }
}