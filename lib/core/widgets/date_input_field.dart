import 'package:flutter/material.dart';

class DateInputField extends StatefulWidget {
  final Function assignDate;
  final DateTime? displayDate;

  const DateInputField(
      {Key? key, required this.assignDate, required this.displayDate})
      : super(key: key);

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  late DateTime? selectedDate;

  @override
  void initState() {
    selectedDate = widget.displayDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        hintText: selectedDate != null
            ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
            : "Select",
        prefixIcon: Icon(
          Icons.calendar_month,
          color: Colors.black.withOpacity(0.6),
        ),
        fillColor: Colors.white.withOpacity(0.6),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 0.4,
          ),
        ),
        errorStyle: TextStyle(
          color: Colors.pink[200],
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 0.4,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 0.4,
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.displayDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null && pickedDate != widget.displayDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      widget.assignDate(pickedDate);
    }
  }
}
