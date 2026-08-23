import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_read_only_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NotePreviewCard extends StatelessWidget {
  const NotePreviewCard({Key? key, required this.note, required this.first, required this.last, required this.index}) : super(key: key);
  final NotePreview note;
  final bool first;
  final bool last;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<HomePageThemeExtensions>()!;
    return BlocBuilder<SelectableListCubit, SelectableListState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<SelectableListCubit>(context);
        final selected = cubit.state.selectedItems.contains(note.id);
        final selecting = state is SelectableListEnabled;
        return GestureDetector(
          onLongPress: () {
            if (state is SelectableListDisabled) cubit.enableSelectableList(note.id);
          },
          onTap: () {
            if (selecting) {
              selected ? cubit.removeItemFromSelection(note.id) : cubit.addItemToSelection(note.id);
            } else {
              Navigator.of(context).pushNamed(NotesReadOnlyPage.routeThroughHome, arguments: note.id);
            }
          },
          child: NoteTile(
            note: note,
            first: first,
            last: last,
            gradientStartColor: selected ? theme.notePreviewSelectedGradientStartColor : theme.notePreviewUnselectedGradientStartColor,
            gradientEndColor: selected ? theme.notePreviewSelectedGradientEndColor : theme.notePreviewUnselectedGradientEndColor,
            borderColor: theme.notePreviewBorderColor,
            leading: selecting ? SelectBox(isSelected: selected, selectableListCubit: cubit, note: note) : null,
            selectModeEnabled: selecting,
          ),
        );
      },
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({Key? key, required this.note, required this.first, required this.last, required this.gradientStartColor, required this.gradientEndColor, required this.borderColor, this.leading, this.selectModeEnabled = false}) : super(key: key);
  final NotePreview note;
  final bool first;
  final bool last;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final Color borderColor;
  final Widget? leading;
  final bool selectModeEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<HomePageThemeExtensions>()!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 10, top: 7, bottom: 10),
      decoration: BoxDecoration(
        border: last
            ? Border(
                bottom: BorderSide(width: 1.3, color: borderColor),
                top: BorderSide(width: 1.3, color: borderColor),
              )
            : Border(
                top: BorderSide(width: 1.3, color: borderColor),
              ),
        gradient: LinearGradient(colors: [gradientStartColor, gradientEndColor], begin: AlignmentDirectional.topStart, end: AlignmentDirectional.bottomEnd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (note.isEncrypted) Padding(padding: const EdgeInsets.only(left: 20, right: 10, top: 2), child: Icon(Icons.lock, size: 20, color: theme.previewTitleColor)),
          if (leading != null) leading!,
          TitleAndDescription(note: note, selectModeEnabled: selectModeEnabled || note.isEncrypted),
          DisplayDate(note: note),
        ],
      ),
    );
  }
}

class SelectBox extends StatelessWidget {
  const SelectBox({Key? key, required this.isSelected, required this.selectableListCubit, required this.note}) : super(key: key);
  final bool isSelected;
  final SelectableListCubit selectableListCubit;
  final NotePreview note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<HomePageThemeExtensions>()!;
    return Checkbox(
      side: BorderSide(color: theme.previewTitleColor),
      value: isSelected,
      activeColor: theme.checkBoxSelectedColor,
      onChanged: (value) => value! ? selectableListCubit.addItemToSelection(note.id) : selectableListCubit.removeItemFromSelection(note.id),
    );
  }
}

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({Key? key, required this.note, required this.selectModeEnabled}) : super(key: key);
  final NotePreview note;
  final bool selectModeEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<HomePageThemeExtensions>()!;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: selectModeEnabled ? 0 : 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: theme.previewTitleColor), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Text(note.plainText, style: TextStyle(fontSize: 15, color: theme.previewBodyColor), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class DisplayDate extends StatelessWidget {
  const DisplayDate({Key? key, required this.note}) : super(key: key);
  final NotePreview note;

  @override
  Widget build(BuildContext context) {
    final dateColor = Theme.of(context).extension<HomePageThemeExtensions>()!.dateColor;
    final style = TextStyle(color: dateColor, fontStyle: FontStyle.italic);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(DateFormat.EEEE().format(note.createdAt), style: style),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text('${DateFormat.MMMd().format(note.createdAt)},', style: style),
          Text(' ${DateFormat.y().format(note.createdAt)}', style: style),
        ]),
      ],
    );
  }
}
