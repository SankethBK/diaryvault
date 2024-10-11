import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/widgets/tag_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteTags extends StatefulWidget {
  const NoteTags({super.key, required this.noteId});

  final String noteId;

  @override
  State<NoteTags> createState() => _NoteTagsState();
}

class _NoteTagsState extends State<NoteTags> {
  var showAddNewTagInput = false;

  @override
  Widget build(BuildContext context) {
    final notesBloc = BlocProvider.of<NotesBloc>(context);
    print("notesBloc in tags = ${notesBloc.state}");
    void addNewTag(String newTag) {
      notesBloc.add(AddTag(newTag: newTag));
    }

    void removeTag(int index) {
      notesBloc.add(DeleteTag(tagIndex: index));
    }

    return BlocBuilder<NotesBloc, NotesState>(
      buildWhen: (previous, current) {
        if (current.id != widget.noteId) {
          return false;
        }

        return true;
      },
      builder: (context, state) {
        final tags = state.tags ?? [];
        return TagList(
          tags: tags,
          addNewTag: addNewTag,
          removeTag: removeTag,
        );
      },
    );
  }
}
