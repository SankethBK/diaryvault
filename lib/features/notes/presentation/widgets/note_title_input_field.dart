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
    return TextField(
      decoration: InputDecoration(
        hintText: "title",
        // prefixIcon: Icon(
        //   Icons.email,
        //   color: Colors.black.withOpacity(0.5),
        // ),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(1),
            width: 1,
          ),
        ),
        // errorText: getEmailErrors(),
        errorStyle: TextStyle(
          color: Colors.pink[200],
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.6),
            width: 1,
          ),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      // onChanged: onEmailChanged,
    );
  }
}
