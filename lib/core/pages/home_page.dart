// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_read_only_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static String get route => '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesFetchCubit = sl<NotesFetchCubit>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: GlassAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/digital-art-neon-bubbles.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.only(
          // top: 60.0,
          left: 10.0,
          right: 10.0,
        ),
        child: BlocBuilder<NotesFetchCubit, NotesFetchState>(
          bloc: notesFetchCubit,
          builder: (context, state) {
            if (state is NotesFetchDummyState) {
              notesFetchCubit.fetchNotes();
              return Center(child: CircularProgressIndicator());
            } else if (state is NotesFetchSuccessful) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final note = state.notePreviewList[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                      NotesReadOnlyPage.routeThroughHome,
                      arguments: note.id,
                    ),
                    child: GlassMorphismCover(
                      displayShadow: false,
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.7),
                              Colors.white.withOpacity(0.5),
                            ],
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.title,
                              style: Theme.of(context).textTheme.headline5,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              note.plainText,
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.notePreviewList.length,
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
  }

  AppBar GlassAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
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
