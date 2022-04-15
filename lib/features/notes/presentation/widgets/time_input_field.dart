import 'package:flutter/material.dart';

class TimeInputField extends StatefulWidget {
  const TimeInputField({Key? key}) : super(key: key);

  @override
  State<TimeInputField> createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () => _selectTime(context),
      decoration: InputDecoration(
        hintText: "${selectedTime.hour}:${selectedTime.minute}",
        prefixIcon: const Icon(
          Icons.timer_outlined,
          color: Colors.black,
        ),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.black,
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

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
