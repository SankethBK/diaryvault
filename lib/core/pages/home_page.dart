// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_read_only_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static String get route => '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesFetchCubit = sl<NotesFetchCubit>();
    final selectableListCubit = sl<SelectableListCubit>();

    return BlocBuilder<SelectableListCubit, SelectableListState>(
      bloc: selectableListCubit,
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: GlassAppBar(selectableListCubit),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/digital-art-neon-bubbles.jpg",
                ),
                fit: BoxFit.cover,
                // alignment: Alignment(0.725, 0.1)
              ),
            ),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top +
                  AppBar().preferredSize.height,
              left: 5.0,
              right: 5.0,
            ),
            // TODO: nested bloc builers, find a way to remove this
            child: BlocBuilder<NotesFetchCubit, NotesFetchState>(
              bloc: notesFetchCubit,
              builder: (context, state) {
                if (state is NotesFetchDummyState) {
                  notesFetchCubit.fetchNotes();
                  return Center(child: CircularProgressIndicator());
                } else if (state is NotesFetchSuccessful) {
                  return GlassMorphismCover(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Container(
                      padding: const EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0.6),
                          ],
                          begin: AlignmentDirectional.topStart,
                          end: AlignmentDirectional.bottomEnd,
                        ),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final note = state.notePreviewList[index];

                          return NotePreviewCard(
                              note: note,
                              selectableListCubit: selectableListCubit);
                        },
                        itemCount: state.notePreviewList.length,
                      ),
                    ),
                  );
                }

                return Container();
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NoteCreatePage.routeThroughHome);
            },
          ),
        );
      },
    );
  }

  AppBar GlassAppBar(SelectableListCubit selectableListCubit) {
    if (selectableListCubit.state is SelectableListEnabled) {
      return AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 25,
          ),
          onPressed: () {
            selectableListCubit.disableSelectableList();
          },
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: Text(
                  "${selectableListCubit.state.selectedItems.length}",
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 13.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                    ),
                    onPressed: () {},
                  )),
            ],
          )
        ],
        flexibleSpace: GlassMorphismCover(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.2),
                ],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
          ),
        ),
      );
    }
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {},
      ),
      actions: [
        const Padding(
          padding: EdgeInsets.only(right: 13.0),
          child: Icon(Icons.search),
        ),
      ],
      flexibleSpace: GlassMorphismCover(
        borderRadius: BorderRadius.circular(0.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.2),
              ],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
