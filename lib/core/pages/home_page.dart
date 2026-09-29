import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/utils/background_image.dart';
import 'package:dairy_app/core/widgets/dashboard_pane_carousel.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/home_page_app_bar.dart';
import 'package:dairy_app/features/auth/presentation/widgets/quit_app_dialog.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/encryption_fab.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/rich_note_preview_card.dart';
import 'package:dairy_app/features/notes/presentation/widgets/search_tag_list.dart';
import 'package:dairy_app/generated/l10n.dart';
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
  final ScrollController _homeScrollController = ScrollController();
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

  void _scrollHomeToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_homeScrollController.hasClients) {
        _homeScrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _homeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImagePath =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.backgroundImage;

    final backgroundColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.backgroundColor;

    final borderColor =
        Theme.of(context).extension<HomePageThemeExtensions>()!.borderColor;

    final backgroundGradientStartColor = Theme.of(context)
        .extension<HomePageThemeExtensions>()!
        .backgroundGradientStartColor;

    final backgroundGradientEndColor = Theme.of(context)
        .extension<HomePageThemeExtensions>()!
        .backgroundGradientEndColor;

    // Keep the full-page glass layer as a frosted blur with only a faint tint
    // so the wallpaper shows through the gaps between widgets, while each
    // widget still carries its own translucent glass surface.
    final homeBackdropGradient = [
      backgroundGradientStartColor.withValues(alpha: 0.6),
      backgroundGradientEndColor.withValues(alpha: 0.4),
    ];

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
        appBar: HomePageAppBar(onSearchClosed: _scrollHomeToTop),
        body: Container(
          decoration: getBackgroundDecoration(
            backgroundImagePath,
            backgroundColor: backgroundColor,
          ),
          padding: EdgeInsets.only(
            top: topPadding,
            left: 5.0,
            right: 5.0,
          ),
          child: GlassMorphismCover(
            sigmaX: 3,
            sigmaY: 2,
            borderRadius: BorderRadius.circular(0.0),
            child: Container(
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                border: Border.all(width: 1.0, color: borderColor),
                gradient: LinearGradient(
                  colors: homeBackdropGradient,
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              child: BlocBuilder<NotesFetchCubit, NotesFetchState>(
                bloc: notesFetchCubit,
                builder: (context, state) {
                  if (state is NotesFetchDummyState) {
                    notesFetchCubit.fetchNotes();
                  }

                  final noteList = state.notePreviewList;
                  final isLoading = state is NotesFetchDummyState ||
                      state is NotesFetchLoadingState;
                  final isFailed = state is NotesFetchFailed;
                  final showStatusRow = noteList.isEmpty && (isLoading || isFailed);

                  return ListView.builder(
                    controller: _homeScrollController,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DashboardPaneCarousel(),
                            SearchTagList(),
                          ],
                        );
                      }
                      final noteIndex = index - 1;
                      if (noteIndex < noteList.length) {
                        final note = noteList[noteIndex];
                        return RichNotePreviewCard(
                          note: note,
                          index: noteIndex,
                          searchText: state.searchText,
                          initiallyExpanded: noteIndex == 0,
                        );
                      }
                      if (isLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (isFailed) {
                        return Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: Text(S.of(context).failedToFetchNote),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    itemCount:
                        noteList.length + 1 + (showStatusRow ? 1 : 0),
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const EncryptionFab(),
            const SizedBox(height: 10),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(NoteCreatePage.routeThroughHome);
              },
            ),
          ],
        ),
      ),
    );
  }
}
