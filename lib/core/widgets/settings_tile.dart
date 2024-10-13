import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.child,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: child,
    );

    return SizedBox(
      height: 30,
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
