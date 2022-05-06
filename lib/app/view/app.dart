import 'package:dairy_app/app/routes/routes.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthSessionBloc>(),
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
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'My dairy',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // accentColor: Color.fromARGB(255, 249, 60, 255),
        accentColor: Colors.pinkAccent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 164, 30, 217).withOpacity(0.5),
            ),
          ),
        ),
      ),
      builder: (BuildContext context, child) {
        final log = printer("App");

        return BlocListener<AuthSessionBloc, AuthSessionState>(
          listener: (context, state) {
            log.d("state is $state");
            if (state is Unauthenticated) {
              _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => AuthPage()),
                  (route) => false);
            } else if (state is Authenticated) {
              _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => HomePage()),
                  (route) => false);
            }
          },
          child: child,
        );
      },
      initialRoute: HomePage.route,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
