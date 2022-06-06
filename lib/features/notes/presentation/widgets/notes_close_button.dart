import 'package:flutter/material.dart';

class NotesCloseButton extends StatelessWidget {
  final Function() onNotesClosed;

  const NotesCloseButton({Key? key, required this.onNotesClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.close,
        size: 25,
      ),
      onPressed: () async {
        bool? result = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("You have unsaved changes"),
                actions: [
                  TextButton(
                    child: const Text('leave'),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
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
                    child: const Text("stay",
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              );
            });
        if (result != null && result == true) {
          onNotesClosed();
        }
      },
    );
  }
}
