import 'package:flutter/material.dart';

class NoteCreateTitle extends StatelessWidget {
  const NoteCreateTitle({
    Key? key,
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
        fillColor: Colors.white.withOpacity(0.7),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.6),
            width: 1,
          ),
        ),
        // errorText: getEmailErrors(),
        errorStyle: TextStyle(
          color: Colors.pink[200],
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      // onChanged: onEmailChanged,
    );
  }
}
