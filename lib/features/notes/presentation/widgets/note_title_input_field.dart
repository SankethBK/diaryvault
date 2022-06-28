import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:flutter/material.dart';

class NoteTitleInputField extends StatelessWidget {
  // final String? Function() getEmailErrors;
  final void Function(String email) onTitleChanged;
  final String initialValue;
  const NoteTitleInputField({
    Key? key,
    // required this.getEmailErrors,
    required this.initialValue,
    required this.onTitleChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textInputBorderRadius = BorderRadius.circular(15.0);
    return GlassMorphismCover(
      borderRadius: textInputBorderRadius,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontWeight: FontWeight.w500),
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: "title",
          hintStyle: const TextStyle(fontWeight: FontWeight.normal),
          fillColor: Colors.white.withOpacity(0.7),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: textInputBorderRadius,
            borderSide: BorderSide(
              color: Colors.white.withOpacity(1),
              width: 0.5,
            ),
          ),
          // errorText: getEmailErrors(),
          errorStyle: TextStyle(
            color: Colors.pink[200],
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: textInputBorderRadius,
            borderSide: BorderSide(
              color: Colors.white.withOpacity(1),
              width: 3,
            ),
          ),
        ),
        onChanged: onTitleChanged,
      ),
    );
  }
}
