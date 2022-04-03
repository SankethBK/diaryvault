import 'dart:ui';

import 'package:flutter/material.dart';

/// A widget that provides glass effect for a [childWidget], here it is used for
/// sign_up and sign_in forms
class GlassFormCover extends StatelessWidget {
  final Widget childWidget;
  const GlassFormCover({Key? key, required this.childWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 16,
            color: Colors.black.withOpacity(0.1),
          )
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 40.0,
              sigmaY: 40.0,
            ),
            child: Container(
              height: deviceWidth * 0.8 + 50,
              width: deviceWidth * 0.8,
              constraints: BoxConstraints(
                // minHeight: 350,
                maxWidth: 500,
                maxHeight: 500,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.2),
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: childWidget,
            ),
          ),
        ),
      ),
    );
  }
}
