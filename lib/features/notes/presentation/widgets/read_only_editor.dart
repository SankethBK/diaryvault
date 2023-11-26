import 'dart:ui';

import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class ReadOnlyEditor extends StatelessWidget {
  final QuillController? controller;
  final FocusNode _focusNode = FocusNode();

  ReadOnlyEditor({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Container();
    }
    return _buildWelcomeEditor(context);
  }

  Widget _buildWelcomeEditor(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    var quillEditor = QuillEditor(
      embedBuilders: [
        ...FlutterQuillEmbeds.builders(),
      ],
      controller: controller!,
      scrollController: ScrollController(),
      scrollable: true,
      focusNode: _focusNode,
      autoFocus: false,
      readOnly: true,
      placeholder: '',
      expands: false,
      padding: EdgeInsets.zero,
      customStyles: DefaultStyles(
        subscript: const TextStyle(fontFamily: 'SF-UI-Display', fontFeatures: [
          FontFeature.subscripts(),
        ]),
        superscript:
            const TextStyle(fontFamily: 'SF-UI-Display', fontFeatures: [
          FontFeature.superscripts(),
        ]),
      ),
    );

    final userConfig = BlocProvider.of<UserConfigCubit>(context);

    return DefaultTextStyle(
      style: TextStyle(
        color: mainTextColor,
        fontFamily: userConfig.state.userConfigModel?.preferredFontFamily,
      ),
      child: quillEditor,
    );
  }
}
