import 'dart:math';

import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   static String get route => '/';

//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Center(child: Text("Home page")),
//       ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  static String get route => '/';

  HomePage({
    Key? key,
  }) : super(key: key);

  final String title = "dnd";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _showFrontSide;
  late bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text(this.widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: RotatedBox(
              child: Icon(Icons.flip),
              quarterTurns: _flipXAxis ? 0 : 1,
            ),
            onPressed: _changeRotationAxis,
          ),
        ],
      ),
      body: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
        child: Center(
          child: Container(
            constraints: BoxConstraints.tight(Size.square(200.0)),
            child: _buildFlipAnimation(),
          ),
        ),
      ),
    );
  }

  void _changeRotationAxis() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _showFrontSide ? _buildFront() : _buildRear(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
        key: ValueKey(true),
        backgroundColor: Colors.blue,
        faceName: "Front",
        child: AuthPage());
  }

  Widget _buildRear() {
    return __buildLayout(
        key: ValueKey(false),
        backgroundColor: Colors.blue.shade700,
        faceName: "Rear",
        child: AuthPage());
  }

  Widget __buildLayout(
      {required Key key,
      required Widget child,
      required String faceName,
      required Color backgroundColor}) {
    return Container(
        key: key,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.0),
          color: backgroundColor,
        ),
        child: child);
    // return Container(
    //   key: key,
    //   decoration: BoxDecoration(
    //     color: backgroundColor,
    //     borderRadius: BorderRadius.circular(12.0),
    //   ),
    //   child: Stack(
    //     fit: StackFit.expand,
    //     children: [
    //       child,
    //       Positioned(
    //         bottom: 8.0,
    //         right: 8.0,
    //         child: Text(faceName),
    //       ),
    //     ],
    //   ),
    // );
  }
}
