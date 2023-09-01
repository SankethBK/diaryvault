import 'package:dairy_app/app/themes/theme_extensions/appbar_theme_extensions.dart';
import 'package:flutter/material.dart';

import 'glassmorphism_cover.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;
  final List<Widget> actions;
  final Widget? leading;
  final Widget? title;
  const GlassAppBar(
      {Key? key,
      this.automaticallyImplyLeading = true,
      this.actions = const [],
      this.leading,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarGradientStartColor = Theme.of(context)
        .extension<AppbarThemeExtensions>()!
        .appBarGradientStartColor;

    final appBarGradientEndColor = Theme.of(context)
        .extension<AppbarThemeExtensions>()!
        .appBarGradientEndColor;

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
                appBarGradientStartColor,
                appBarGradientEndColor,
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
