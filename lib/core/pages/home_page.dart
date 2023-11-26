import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/home_page_app_bar.dart';
import 'package:dairy_app/features/auth/presentation/widgets/quit_app_dialog.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_preview_card.dart';
import 'package:dairy_app/features/notes/presentation/widgets/search_tag_list.dart';
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
  late double topPadding = 0;

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
      topPadding =
          MediaQuery.of(context).padding.top + AppBar().preferredSize.height;
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImagePath =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.backgroundImage;

    final borderColor =
        Theme.of(context).extension<HomePageThemeExtensions>()!.borderColor;

    final backgroundGradientStartColor = Theme.of(context)
        .extension<HomePageThemeExtensions>()!
        .backgroundGradientStartColor;

    final backgroundGradientEndColor = Theme.of(context)
        .extension<HomePageThemeExtensions>()!
        .backgroundGradientEndColor;

    final sigmaX =
        Theme.of(context).extension<HomePageThemeExtensions>()!.sigmaX;

    final sigmaY =
        Theme.of(context).extension<HomePageThemeExtensions>()!.sigmaY;

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
        appBar: const HomePageAppBar(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                backgroundImagePath,
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.only(
            top: topPadding,
            left: 5.0,
            right: 5.0,
          ),
          child: GlassMorphismCover(
            sigmaX: sigmaX,
            sigmaY: sigmaY,
            borderRadius: BorderRadius.circular(0.0),
            child: Container(
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                border: Border.all(width: 1.0, color: borderColor),
                gradient: LinearGradient(
                  colors: [
                    backgroundGradientStartColor,
                    backgroundGradientEndColor,
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
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NotesFetchSuccessful ||
                      state is NotesSortSuccessful) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const SearchTagList();
                        }
                        final note = state.notePreviewList[index - 1];

                        return NotePreviewCard(
                          first: index == 1,
                          last: index == state.notePreviewList.length,
                          note: note,
                        );
                      },
                      itemCount: state.notePreviewList.length + 1,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(NoteCreatePage.routeThroughHome);
          },
        ),
      ),
    );
  }
}
