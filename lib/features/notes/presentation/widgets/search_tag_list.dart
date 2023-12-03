import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/widgets/tag_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTagList extends StatelessWidget {
  const SearchTagList({super.key});

  @override
  Widget build(BuildContext context) {
    final notesFetchCubit = BlocProvider.of<NotesFetchCubit>(context);

    void addNewTag(String newTag) {
      notesFetchCubit.addNewTag(newTag);
    }

    void removeTag(int index) {
      notesFetchCubit.deleteTag(index);
    }

    return BlocBuilder<NotesFetchCubit, NotesFetchState>(
      builder: (context, state) {
        final isTagSearchEnabled = state.isTagSearchEnabled;
        final tags = state.tags;

        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isTagSearchEnabled
                ? TagList(
                    tags: tags,
                    addNewTag: addNewTag,
                    removeTag: removeTag,
                  )
                : const SizedBox.shrink());
      },
    );
  }
}
