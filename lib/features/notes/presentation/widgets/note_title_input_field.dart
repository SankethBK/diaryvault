import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:flutter/material.dart';

class NoteTitleInputField extends StatelessWidget {
  // final String? Function() getEmailErrors;
  // final void Function(String email) onEmailChanged;
  const NoteTitleInputField({
    Key? key,
    // required this.getEmailErrors,
    // required this.onEmailChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textInputBorderRadius = BorderRadius.circular(15.0);
    return GlassMorphismCover(
      borderRadius: textInputBorderRadius,
      child: TextField(
        decoration: InputDecoration(
          hintText: "title",
          fillColor: Colors.white.withOpacity(0.7),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: textInputBorderRadius,
            borderSide: BorderSide(
              color: Colors.white.withOpacity(1),
              width: 1,
            ),
          ),
          // errorText: getEmailErrors(),
          errorStyle: TextStyle(
            color: Colors.pink[200],
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: textInputBorderRadius,
            borderSide: BorderSide(
              color: Colors.white.withOpacity(1),
              width: 3,
            ),
          ),
        ), // onChanged: onEmailChanged,
      ),
    );
  }
}
