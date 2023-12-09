import 'package:dairy_app/features/auth/presentation/widgets/fingerprint_button.dart';
import 'package:dairy_app/features/auth/presentation/widgets/number_button.dart';
import 'package:dairy_app/features/auth/presentation/widgets/backspace_button.dart';
import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(String) addPINDigit;
  final Function() deletePINDigit;

  const NumberPad(
      {super.key, required this.addPINDigit, required this.deletePINDigit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumberButton(value: "1", addPINDigit: addPINDigit),
            NumberButton(value: "2", addPINDigit: addPINDigit),
            NumberButton(value: "3", addPINDigit: addPINDigit),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumberButton(value: "4", addPINDigit: addPINDigit),
            NumberButton(value: "5", addPINDigit: addPINDigit),
            NumberButton(value: "6", addPINDigit: addPINDigit),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumberButton(value: "7", addPINDigit: addPINDigit),
            NumberButton(value: "8", addPINDigit: addPINDigit),
            NumberButton(value: "9", addPINDigit: addPINDigit),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FingerprintButton(),
            NumberButton(value: "0", addPINDigit: addPINDigit),
            BackspaceButton(deletePINDigit: deletePINDigit),
          ],
        ),
      ],
    );
  }
}
