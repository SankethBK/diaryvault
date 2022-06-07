import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;

  const CancelButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.purple,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
