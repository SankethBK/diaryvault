import 'package:dairy_app/app/routes/routes.dart';
import 'package:dairy_app/app/themes/coral_bubble_theme.dart';
import 'package:dairy_app/app/themes/cosmic_theme.dart';
import 'package:dairy_app/app/themes/lush_green_theme.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/cubit/theme_cubit.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final log = printer("App");

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthSessionBloc>(
          create: (context) => sl<AuthSessionBloc>(),
        ),
        BlocProvider<AuthFormBloc>(
          create: (context) => sl<AuthFormBloc>(),
        ),
        BlocProvider<NotesBloc>(
          create: (context) => sl<NotesBloc>(),
        ),
        BlocProvider<NotesFetchCubit>(
          create: (context) => sl<NotesFetchCubit>(),
        ),
        BlocProvider<SelectableListCubit>(
          create: (context) => sl<SelectableListCubit>(),
        ),
        BlocProvider<NoteSyncCubit>(
          create: (context) => sl<NoteSyncCubit>(),
        ),
        BlocProvider<UserConfigCubit>(
          create: (context) => sl<UserConfigCubit>(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => sl<ThemeCubit>(),
        )
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  AppView({
    Key? key,
  }) : super(key: key);

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
      // trigger the initialization of lastLoggedinUserId
      BlocProvider.of<AuthSessionBloc>(context)
          .add(InitalizeLastLoggedInUser());
      _isInitialized = true;
    }
  }

  NavigatorState get _navigator => _navigatorKey.currentState!;

  ThemeData getThemeData(Themes currentTheme) {
    switch (currentTheme) {
      case Themes.coralBubbles:
        return CoralBubble.getTheme();
      case Themes.cosmic:
        return Cosmic.getTheme();
      case Themes.lushGreen:
        return LushGreen.getTheme();

      default:
        return Cosmic.getTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'My dairy',
          theme: getThemeData(state.theme),
          builder: (BuildContext context, child) {
            return BlocListener<AuthSessionBloc, AuthSessionState>(
              listener: (context, state) {
                log.d("Auth session state is $state");

                //! Currently we are not passing lastLoggedinUser anywhere, if you implement session
                //! Rememeber to pass lastloggedinuser id as parameter to AuthPage

                if (state is Unauthenticated) {
                  if (state.sessionTimeoutLogout == true) {
                    _navigator.pushNamed(AuthPage.route);
                  } else {
                    _navigator.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => AuthPage()),
                        (route) => false);
                  }
                } else if (state is Authenticated) {
                  log.d("freshLogin = ${state.freshLogin}");

                  if (state.freshLogin == true) {
                    _navigator.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false);
                  } else {
                    _navigator.pop();
                  }
                }
              },
              child: child,
            );
          },
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}
