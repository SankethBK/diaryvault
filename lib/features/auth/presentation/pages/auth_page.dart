// ignore_for_file: prefer_const_constructors

import 'package:dairy_app/core/animations/flip_card_animation.dart';
import 'package:dairy_app/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:dairy_app/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);
  static String get route => '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/digital-art-neon-bubbles.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: FlipCardAnimation(
          frontWidget: (void Function() flipCard) {
            return SignUpForm(flipCard: flipCard);
          },
          rearWidget: (void Function() flipCard) {
            return SignInForm(flipCard: flipCard);
          },
        ),
      ),
    );
  }
}

// shdjdjeui