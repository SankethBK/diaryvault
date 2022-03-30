import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/features/auth/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    if (settings.name == HomePage.route) {
      return MaterialPageRoute(builder: (_) => HomePage());
    } else if (settings.name == AuthPage.route) {
      return MaterialPageRoute(builder: (_) => AuthPage());
    }
    return MaterialPageRoute(
      builder: (_) => Container(
        child: Center(
          child: Text("page not found"),
        ),
      ),
    );
  }
}
