import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.child,
    this.onTap,
    this.height = 30,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    final widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: child,
    );

    return SizedBox(
      height: height,
      width: double.infinity,
      child: null == onTap
          ? widget
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: widget,
              ),
            ),
    );
  }
}
