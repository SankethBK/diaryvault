import 'package:dairy_app/app/themes/theme_extensions/chip_theme_extensions.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteTags extends StatelessWidget {
  const NoteTags({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.backgroundColor;

    final deleteIconColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.deleteIconColor;

    final textColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.textColor;

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        final tags = state.tags ?? [];

        return SizedBox(
          height: 48.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Chip(
                  label: Text(
                    tags[index],
                    style: TextStyle(color: textColor),
                  ),
                  backgroundColor: backgroundColor,
                  deleteIconColor: deleteIconColor,
                  onDeleted: () {},
                ),
              );
            },
          ),
        );
      },
    );
  }
}
