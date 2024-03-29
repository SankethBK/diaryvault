import 'dart:ui';

import 'package:flutter/material.dart';

/// A widget that provides glass effect for a [child],
/// Since color and dimensions of Container have to be in same Container, the childWIdget
/// has to specify gradient and borders by itself
class GlassMorphismCover extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final bool displayShadow;
  final double sigmaX;
  final double sigmaY;
  const GlassMorphismCover({
    Key? key,
    required this.child,
    required this.borderRadius,
    this.displayShadow = true,
    this.sigmaX = 40.0,
    this.sigmaY = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 16,
            color: Colors.black.withOpacity(displayShadow ? 0.1 : 0.0),
          )
        ]),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: sigmaX,
              sigmaY: sigmaY,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
