import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notes/notes_bloc.dart';

class NoteSaveButton extends StatelessWidget {
  const NoteSaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);
    return BlocBuilder<NotesBloc, NotesState>(
      bloc: notesBloc,
      builder: (context, state) {
        if (state.safe && state is! NoteSaveLoading) {
          return Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => notesBloc.add(SaveNote()),
            ),
          );
        }

        if (state is NoteSaveLoading) {
          return Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: IconButton(
              icon: const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              onPressed: () => notesBloc.add(SaveNote()),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
