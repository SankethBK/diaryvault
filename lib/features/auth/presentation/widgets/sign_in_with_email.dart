import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class SignInWithEmail extends StatelessWidget {
  const SignInWithEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final linkColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.linkColor;

    return GlassMorphismCover(
      sigmaX: 20,
      sigmaY: 20,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AuthPage.route);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            S.current.signInWithEmail,
            style: TextStyle(
              color: linkColor,
            ),
          ),
        ),
      ),
    );
  }
}
