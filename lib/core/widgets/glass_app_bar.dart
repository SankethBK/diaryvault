import 'package:flutter/material.dart';

import 'glassmorphism_cover.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;
  final List<Widget> actions;
  final Widget leading;
  final Widget title;
  const GlassAppBar(
      {Key? key,
      this.automaticallyImplyLeading = true,
      this.actions = const [],
      this.leading = const SizedBox.shrink(),
      this.title = const SizedBox.shrink()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      backgroundColor: Colors.transparent,
      title: title,
      actions: actions,
      flexibleSpace: GlassMorphismCover(
        borderRadius: BorderRadius.circular(0.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.2),
              ],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
