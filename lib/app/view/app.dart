import 'package:dairy_app/app/routes/routes.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
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
        )
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({
    Key? key,
  }) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final authSessionBloc = BlocProvider.of<AuthSessionBloc>(context);

    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 5),
      invalidateSessionForUserInactiviity: null,
    );
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      log.d("Session timeout stream value: $timeoutEvent");

      if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        authSessionBloc.add(AppLostFocus());
      }
    });

    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'My dairy',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.pinkAccent.withOpacity(0.5),
              ),
            ),
          ),
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
            secondary: Colors.pinkAccent,
          ),
        ),
        builder: (BuildContext context, child) {
          return BlocListener<AuthSessionBloc, AuthSessionState>(
            listener: (context, state) {
              log.d("Auth session state is $state");
              if (state is Unauthenticated) {
                if (state.sessionTimeoutLogout == true) {
                  _navigator.pushNamed(AuthPage.route);
                } else {
                  _navigator.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => AuthPage()),
                      (route) => false);
                }
              } else if (state is Authenticated) {
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
        initialRoute: AuthPage.route,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
