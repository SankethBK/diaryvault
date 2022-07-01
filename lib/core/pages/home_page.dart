// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/home_page_app_bar.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/widgets/quit_app_dialog.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static String get route => '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _isInitialized = false;
  late final NotesFetchCubit notesFetchCubit;
  late final SelectableListCubit selectableListCubit;

  @override
  void initState() {
    notesFetchCubit = sl<NotesFetchCubit>();
    notesFetchCubit.fetchNotes();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      selectableListCubit = BlocProvider.of<SelectableListCubit>(context);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool res = await quitAppDialog(context);
        if (res == true) {
          SystemNavigator.pop();
        }

        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: HomePageAppBar(),
        body: Container(
          decoration: const BoxDecoration(
            // color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                "assets/images/digital-art-neon-bubbles.jpg",
              ),
              fit: BoxFit.cover,
              alignment: Alignment(0.725, 0.1),
              // alignment: Alignment(0.725, 0.1)
            ),
          ),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top +
                AppBar().preferredSize.height,
            left: 5.0,
            right: 5.0,
          ),
          child: GlassMorphismCover(
            borderRadius: BorderRadius.circular(0.0),
            child: Container(
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                border: Border.all(width: 1.0, color: Colors.white),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.6),
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              child: BlocBuilder<NotesFetchCubit, NotesFetchState>(
                bloc: notesFetchCubit,
                builder: (context, state) {
                  if (state is NotesFetchDummyState) {
                    notesFetchCubit.fetchNotes();
                    return Center(child: CircularProgressIndicator());
                  } else if (state is NotesFetchSuccessful) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final note = state.notePreviewList[index];

                        return NotePreviewCard(
                          first: index == 0,
                          last: index == state.notePreviewList.length - 1,
                          note: note,
                        );
                      },
                      itemCount: state.notePreviewList.length,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(NoteCreatePage.routeThroughHome);
          },
        ),
      ),
    );
  }
}
