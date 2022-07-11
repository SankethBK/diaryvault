import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final Function() onSubmitted;
  final String buttonText;
  const SubmitButton({
    Key? key,
    required this.isLoading,
    required this.onSubmitted,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const SizedBox.shrink(),
      onPressed: isLoading ? null : onSubmitted,
      label: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        onPrimary: Colors.pink[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        elevation: 2,
        side: BorderSide(
          color: Colors.black.withOpacity(0.5),
          width: 1,
        ),
      ),
    );
  }
}
