import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:flutter/material.dart';

class BackspaceButton extends StatelessWidget {
  final Function() deletePINDigit;

  const BackspaceButton({super.key, required this.deletePINDigit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        borderRadius: BorderRadius.circular(50),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: deletePINDigit,
          child: GlassMorphismCover(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(50), // Adjust the radius as needed
                border: Border.all(
                  color: Colors.white.withOpacity(0.7),
                  // width: 2,
                ),
              ),
              child: Icon(
                Icons.backspace,
                size: 30,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
