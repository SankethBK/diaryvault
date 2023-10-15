import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/notes/core/exports.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);

    return BlocBuilder<NotesBloc, NotesState>(
      bloc: notesBloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 13.0),
          child: IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: state.createdAt!,
                firstDate: DateTime(1900),
                lastDate: DateTime(3000),
              );

              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(state.createdAt!),
                initialEntryMode: TimePickerEntryMode.dial,
              );

              final createdAt = DateTime(pickedDate!.year, pickedDate.month,
                  pickedDate.day, timeOfDay!.hour, timeOfDay.minute);
              notesBloc.add(UpdateNote(createdAt: createdAt));
            },
          ),
        );
      },
    );
  }
}
