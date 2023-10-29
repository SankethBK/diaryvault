import 'package:dairy_app/app/themes/theme_extensions/chip_theme_extensions.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/widgets/tag_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteTags extends StatefulWidget {
  const NoteTags({super.key});

  @override
  State<NoteTags> createState() => _NoteTagsState();
}

class _NoteTagsState extends State<NoteTags> {
  var showAddNewTagInput = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.backgroundColor;

    final deleteIconColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.iconColor;

    final textColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.textColor;

    final notesBloc = BlocProvider.of<NotesBloc>(context);

    void addNewTag(String newTag) {
      notesBloc.add(AddTag(newTag: newTag));
    }

    void closeTagTextInput() {
      setState(() {
        showAddNewTagInput = false;
      });
    }

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        final tags = state.tags ?? [];
        return SizedBox(
          height: 50.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tags.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: showAddNewTagInput
                      ? SizedBox(
                          width: 180,
                          child: TagTextInput(
                            onSubmit: addNewTag,
                            onCancel: closeTagTextInput,
                            autoFocus: true,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              showAddNewTagInput = true;
                            });
                          },
                          child: Chip(
                            label: Text(
                              "+",
                              style: TextStyle(color: textColor, fontSize: 23),
                            ),
                            backgroundColor: backgroundColor,
                          ),
                        ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(
                    label: Text(
                      tags[index - 1],
                      style: TextStyle(color: textColor),
                    ),
                    backgroundColor: backgroundColor,
                    deleteIconColor: deleteIconColor,
                    onDeleted: () {
                      notesBloc.add(DeleteTag(tagIndex: index - 1));
                    },
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
