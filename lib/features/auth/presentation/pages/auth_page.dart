// ignore_for_file: prefer_const_constructors

import 'package:dairy_app/core/animations/flip_card_animation.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/features/auth/data/repositories/fingerprint_auth_repo.dart';
import 'package:dairy_app/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:dairy_app/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  // user id of last logged in user to determine if it is a fresh login or not
  final String? lastLoggedInUserId;
  late FingerPrintAuthRepository fingerPrintAuthRepository;

  AuthPage({Key? key, this.lastLoggedInUserId}) : super(key: key) {
    fingerPrintAuthRepository = sl<FingerPrintAuthRepository>();
    fingerPrintAuthRepository.startFingerPrintAuthIfNeeded();
  }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlipCardAnimation(
              frontWidget: (void Function() flipCard) {
                return SignUpForm(flipCard: flipCard);
              },
              rearWidget: (void Function() flipCard) {
                return SignInForm(
                    flipCard: flipCard, lastLoggedInUserId: lastLoggedInUserId);
              },
            ),
            const SizedBox(height: 40),
            if (fingerPrintAuthRepository.shouldActivateFingerPrint())
              Icon(
                Icons.fingerprint,
                size: 50,
                color: Colors.white.withOpacity(0.5),
              )
          ],
        ),
      ),
    );
  }
}

// shdjdjeui