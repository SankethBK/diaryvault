import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestSignUp extends StatelessWidget {
  const GuestSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linkColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.linkColor;
    return GestureDetector(
      onTap: () {
        final authFormbloc = BlocProvider.of<AuthFormBloc>(context);
        authFormbloc.add(AuthFormGuestSignIn());
      },
      child: Text(
        "Continue as guest",
        style: TextStyle(
          color: linkColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
