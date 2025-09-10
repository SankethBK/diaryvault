import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:flutter/material.dart';

class AuthChangePage extends StatelessWidget {
  const AuthChangePage({
    Key? key,
    required this.infoText,
    required this.flipPageText,
    required this.flipCard,
  }) : super(key: key);

  final String infoText;
  final String flipPageText;
  final Function() flipCard;

  @override
  Widget build(BuildContext context) {
    final linkColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.linkColor;

    final infoTextColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.infoTextColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          infoText,
          style: TextStyle(
            color: infoTextColor,
          ),
        ),
        GestureDetector(
          onTap: flipCard,
          child: Container(
            color: Colors.transparent,
            padding:
                const EdgeInsets.only(right: 20, left: 5, top: 6, bottom: 6),
            child: Text(
              flipPageText,
              style: TextStyle(
                color: linkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
