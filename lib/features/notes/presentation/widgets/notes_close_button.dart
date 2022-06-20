import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesCloseButton extends StatelessWidget {
  final Function() onNotesClosed;

  const NotesCloseButton({Key? key, required this.onNotesClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.safe) {
          return IconButton(
            icon: const Icon(
              Icons.close,
              size: 25,
            ),
            onPressed: () async {
              bool? result = await showCustomDialog(
                context: context,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 120,
                  width: 300,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "You have unsaved changes",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CancelButton(
                              buttonText: "Leave",
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                            const SizedBox(width: 10),
                            SubmitButton(
                              isLoading: false,
                              onSubmitted: () => Navigator.pop(context, false),
                              buttonText: "Stay",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
              if (result != null && result == true) {
                onNotesClosed();
              }
            },
          );
        }
        return Container();
      },
    );
  }
}
