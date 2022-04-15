import 'package:flutter/material.dart';

class DateInputField extends StatefulWidget {
  const DateInputField({Key? key}) : super(key: key);

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        hintText:
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
        prefixIcon: Icon(
          Icons.calendar_month,
          color: Colors.black.withOpacity(0.6),
        ),
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

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
