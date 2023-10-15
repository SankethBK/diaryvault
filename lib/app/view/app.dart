import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';
import 'package:dairy_app/features/notes/core/exports.dart';
import 'package:dairy_app/features/sync/core/exports.dart';

import '../../features/auth/presentation/bloc/user_config/user_config_cubit.dart';

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
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
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
          title: "My Dairy",
          supportedLocales: const [
            Locale('en'),
            Locale('hi'),
            Locale('pa'),
            Locale('he'),
            Locale('kn'),
            Locale('pt', "BR"),
            Locale('sw'),
            Locale('ar')
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
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
