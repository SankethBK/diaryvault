import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String get route => '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text("Home page")),
      ),
    );
  }
}
