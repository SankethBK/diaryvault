import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:dairy_app/app/routes/routes.dart';
import 'package:dairy_app/app/themes/coral_bubble_theme.dart';
import 'package:dairy_app/app/themes/cosmic_theme.dart';
import 'package:dairy_app/app/themes/dark_academia.dart';
import 'package:dairy_app/app/themes/lush_green_theme.dart';
import 'package:dairy_app/app/themes/monochrome_pink.dart';
import 'package:dairy_app/app/themes/plain_dark.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/features/auth/data/repositories/pin_auth_repository.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/font/font_cubit.dart';
import 'package:dairy_app/features/auth/presentation/bloc/locale/locale_cubit.dart';
import 'package:dairy_app/features/auth/presentation/bloc/theme/theme_cubit.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/features/auth/presentation/pages/pin_auth_page.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';

final log = printer("App");

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _createBlocProviders(),
      child: const AppView(),
    );
  }

  List<BlocProvider> _createBlocProviders() {
    return [
      BlocProvider<AuthSessionBloc>(create: (_) => sl<AuthSessionBloc>()),
      BlocProvider<AuthFormBloc>(create: (_) => sl<AuthFormBloc>()),
      BlocProvider<NotesBloc>(create: (_) => sl<NotesBloc>()),
      BlocProvider<NotesFetchCubit>(create: (_) => sl<NotesFetchCubit>()),
      BlocProvider<SelectableListCubit>(create: (_) => sl<SelectableListCubit>()),
      BlocProvider<NoteSyncCubit>(create: (_) => sl<NoteSyncCubit>()),
      BlocProvider<UserConfigCubit>(create: (_) => sl<UserConfigCubit>()),
      BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
      BlocProvider<LocaleCubit>(create: (_) => sl<LocaleCubit>()),
      BlocProvider<FontCubit>(create: (_) => sl<FontCubit>()),
    ];
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      BlocProvider.of<AuthSessionBloc>(context).add(InitalizeLastLoggedInUser());
      _isInitialized = true;
    }
  }

  NavigatorState get _navigator => _navigatorKey.currentState!;

  ThemeData _getThemeData(Themes currentTheme, FontFamily fontFamily) {
    switch (currentTheme) {
      case Themes.coralBubbles:
        return CoralBubble.getTheme(fontFamily);
      case Themes.cosmic:
        return Cosmic.getTheme(fontFamily);
      case Themes.lushGreen:
        return LushGreen.getTheme(fontFamily);
      case Themes.plainDark:
        return PlainDark.getTheme(fontFamily);
      case Themes.darkAcademia:
        return DarkAcademia.getTheme(fontFamily);
      case Themes.monochromePink:
        return MonochromePink.getTheme(fontFamily);
      default:
        return CoralBubble.getTheme(fontFamily);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
            return BlocBuilder<FontCubit, FontState>(
              builder: (context, fontState) {
                return MaterialApp(
                  navigatorKey: _navigatorKey,
                  debugShowCheckedModeBanner: false,
                  title: "My Dairy",
                  locale: localeState.currentLocale,
                  supportedLocales: S.delegate.supportedLocales,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  theme: _getThemeData(themeState.theme, fontState.currentFontFamily),
                  builder: _buildAuthSessionListener,
                  onGenerateRoute: RouteGenerator.generateRoute,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAuthSessionListener(BuildContext context, Widget? child) {
    return BlocListener<AuthSessionBloc, AuthSessionState>(
      listener: (context, state) {
        log.d("Auth session state is $state");
        if (state is Unauthenticated) {
          _navigateToAuthPage();
        } else if (state is Authenticated) {
          _navigateToHomePage(state.freshLogin);
        }
      },
      child: child,
    );
  }

  void _navigateToAuthPage() {
    final isPINLoginEnabled = sl<PINAuthRepository>().isPINAuthEnabled();
    _navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => isPINLoginEnabled ? const PINAuthPage() : const AuthPage(),
      ),
          (route) => false,
    );
  }

  void _navigateToHomePage(bool freshLogin) {
    if (freshLogin) {
      _navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
      );
    } else {
      _navigator.pop();
    }
  }
}
