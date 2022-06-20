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
  final bool first;
  final bool last;
  NotePreviewCard({
    Key? key,
    required this.note,
    required this.selectableListCubit,
    required this.first,
    required this.last,
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
        padding: const EdgeInsets.only(right: 10, left: 0, top: 7, bottom: 10),
        decoration: BoxDecoration(
          border: last
              ? Border(
                  bottom: BorderSide(
                      width: 1.3, color: Colors.white.withOpacity(0.6)),
                  top: BorderSide(
                      width: 1.3, color: Colors.white.withOpacity(0.6)),
                )
              : Border(
                  top: BorderSide(
                      width: 1.3, color: Colors.white.withOpacity(0.6)),
                ),
          gradient: LinearGradient(
            colors: [
              isSelected
                  ? const Color.fromARGB(255, 210, 161, 238).withOpacity(0.5)
                  : Colors.transparent,
              const Color.fromARGB(255, 210, 161, 238).withOpacity(0.2),
            ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectableListCubit.state is SelectableListEnabled)
              SelectBox(
                  isSelected: isSelected,
                  selectableListCubit: selectableListCubit,
                  note: note),
            TitleAndDescription(
                note: note,
                selectModeEnabled:
                    (selectableListCubit.state is SelectableListEnabled)),
            DisplayDate(note: note),
          ],
        ),
      ),
    );
  }
}

class SelectBox extends StatelessWidget {
  const SelectBox({
    Key? key,
    required this.isSelected,
    required this.selectableListCubit,
    required this.note,
  }) : super(key: key);

  final bool isSelected;
  final SelectableListCubit selectableListCubit;
  final NotePreview note;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: ((context, setState) => Checkbox(
            value: isSelected,
            activeColor: Colors.pinkAccent,
            onChanged: (val) {
              val!
                  ? selectableListCubit.addItemToSelection(note.id)
                  : selectableListCubit.removeItemFromSelection(note.id);
            },
          )),
    );
  }
}

class TitleAndDescription extends StatelessWidget {
  final bool selectModeEnabled;
  const TitleAndDescription({
    Key? key,
    required this.note,
    required this.selectModeEnabled,
  }) : super(key: key);

  final NotePreview note;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: selectModeEnabled ? 0 : 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 7),
            Text(
              note.title,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
  }
}

class DisplayDate extends StatelessWidget {
  const DisplayDate({
    Key? key,
    required this.note,
  }) : super(key: key);

  final NotePreview note;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          DateFormat.EEEE().format(note.createdAt),
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontStyle: FontStyle.italic,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              DateFormat.MMMd().format(note.createdAt) + ",",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.black.withOpacity(1.0),
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              " " + DateFormat.y().format(note.createdAt),
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
