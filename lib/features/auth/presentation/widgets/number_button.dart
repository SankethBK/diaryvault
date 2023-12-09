import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final String value;
  final Function(String) addPINDigit;

  const NumberButton(
      {super.key, required this.value, required this.addPINDigit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        borderRadius: BorderRadius.circular(50),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () => addPINDigit(value),
          child: GlassMorphismCover(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(50), // Adjust the radius as needed
                border: Border.all(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              child: Center(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
