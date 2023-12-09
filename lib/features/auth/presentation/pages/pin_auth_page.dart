import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/auth/data/repositories/pin_auth_repository.dart';
import 'package:dairy_app/features/auth/presentation/widgets/number_pad.dart';
import 'package:dairy_app/features/auth/presentation/widgets/sign_in_with_email.dart';
import 'package:flutter/material.dart';

class PINAuthPage extends StatefulWidget {
  static String get route => '/pin-auth';

  const PINAuthPage({super.key});

  @override
  State<PINAuthPage> createState() => _PINAuthPageState();
}

class _PINAuthPageState extends State<PINAuthPage> {
  String pin = '';
  final int pinLength = 4;

  void addPINDigit(String digit) {
    if (pin.length < pinLength) {
      setState(() {
        pin += digit;
      });
    }

    if (pin.length == 4) {
      submitPIN();
    }
  }

  void deletePINDigit() {
    if (pin.isNotEmpty) {
      setState(() {
        pin = pin.substring(0, pin.length - 1);
      });
    }
  }

  void submitPIN() async {
    await sl<PINAuthRepository>().verifyPINAndLogin(pin);
    setState(() {
      pin = '';
    });
  }

  Widget buildPINDisplay() {
    List<Widget> pinDots = [];
    for (int i = 0; i < pinLength; i++) {
      pinDots.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          width: 20.0,
          height: 20.0,
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: i < pin.length
                ? Colors.white.withOpacity(0.4)
                : Colors.transparent,

            borderRadius:
                BorderRadius.circular(50), // Adjust the radius as needed
            border: Border.all(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      );
    }
    return GlassMorphismCover(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: 350,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(50), // Adjust the radius as needed
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Enter your PIN',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pinDots,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImagePath =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.backgroundImage;

    final textColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.textColor;

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              backgroundImagePath,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildPINDisplay(),
                const SizedBox(height: 80),
                NumberPad(
                  addPINDigit: addPINDigit,
                  deletePINDigit: deletePINDigit,
                ),
                const SizedBox(height: 50),
                const SignInWithEmail(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
