import 'package:dairy_app/core/constants/exports.dart';

class AuthPasswordInput extends StatefulWidget {
  final String? Function() getPasswordErrors;
  final void Function(String password) onPasswordChanged;
  final bool autoFocus;
  final String hintText;
  const AuthPasswordInput({
    Key? key,
    required this.getPasswordErrors,
    required this.onPasswordChanged,
    this.autoFocus = false,
    this.hintText = "password",
  }) : super(key: key);

  @override
  State<AuthPasswordInput> createState() => _AuthPasswordInputState();
}

class _AuthPasswordInputState extends State<AuthPasswordInput> {
  bool _passwordVisibility = true;

  void _togglePasswordVisibility() => setState(() {
        _passwordVisibility = !_passwordVisibility;
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
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: hintTextColor),
            prefixIcon: Icon(
              Icons.lock,
              color: prefixIconColor,
            ),
            suffixIcon: InkWell(
              onTap: _togglePasswordVisibility,
              child: Icon(
                !_passwordVisibility ? Icons.visibility : Icons.visibility_off,
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
            errorText: widget.getPasswordErrors(),
            errorStyle: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          obscureText: _passwordVisibility,
          onChanged: widget.onPasswordChanged,
        ),
      ],
    );
  }
}
