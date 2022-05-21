import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_read_only_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NotePreviewCard extends StatelessWidget {
  final SelectableListCubit selectableListCubit;
  late bool isSelected;
  NotePreviewCard({
    Key? key,
    required this.note,
    required this.selectableListCubit,
  }) : super(key: key) {
    isSelected = selectableListCubit.state.selectedItems.contains(note.id);
  }

  final NotePreview note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (selectableListCubit.state is SelectableListDisabled) {
          selectableListCubit.enableSelectableList(note.id);
        }
      },
      onTap: () {
        if (selectableListCubit.state is SelectableListEnabled) {
          isSelected
              ? selectableListCubit.removeItemFromSelection(note.id)
              : selectableListCubit.addItemToSelection(note.id);
        } else {
          Navigator.of(context).pushNamed(
            NotesReadOnlyPage.routeThroughHome,
            arguments: note.id,
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 10),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 0.3,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.pink.withOpacity(0.3),
              Colors.transparent,
            ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMEd().format(note.createdAt),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    note.title,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    note.plainText,
                    style: const TextStyle(fontSize: 16.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            if (selectableListCubit.state is SelectableListEnabled)
              StatefulBuilder(
                builder: ((context, setState) => Checkbox(
                      value: isSelected,
                      activeColor: Colors.pinkAccent,
                      onChanged: (val) {
                        print("val = $val");
                        val!
                            ? selectableListCubit.addItemToSelection(note.id)
                            : selectableListCubit
                                .removeItemFromSelection(note.id);
                      },
                    )),
              )
          ],
        ),
      ),
    );
  }
}


/*

 return GlassMorphismCover(
      displayShadow: false,
      borderRadius: BorderRadius.circular(0.0),
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 10),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5.0),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.0),
              Colors.white.withOpacity(0.0),
            ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMEd().format(note.createdAt),
              style: const TextStyle(
                color: Color.fromARGB(255, 103, 101, 101),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(width: 7),
            Text(
              note.title,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              note.plainText,
              style: const TextStyle(fontSize: 16.0),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );

    */