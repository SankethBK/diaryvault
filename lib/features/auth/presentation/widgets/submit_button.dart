import 'package:flutter/material.dart';

class AuthSubmitButton extends StatelessWidget {
  final bool isLoading;
  final Function() onSubmitted;
  const AuthSubmitButton(
      {Key? key, required this.isLoading, required this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: isLoading
          ? SizedBox(
              child: CircularProgressIndicator(
                color: Colors.white.withOpacity(0.5),
              ),
              width: 20,
              height: 20,
            )
          : const SizedBox.shrink(),
      onPressed: isLoading ? null : onSubmitted,
      label: const Text(
        "Submit",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        onPrimary: Colors.purple[200],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        elevation: 4,
        side: BorderSide(
          color: Colors.black.withOpacity(0.5),
          width: 1,
        ),
      ),
    );
  }
}
