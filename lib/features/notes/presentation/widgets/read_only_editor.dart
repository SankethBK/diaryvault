import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tuple/tuple.dart';

class ReadOnlyEditor extends StatelessWidget {
  QuillController? controller;
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
    var quillEditor = QuillEditor(
      controller: controller!,
      scrollController: ScrollController(),
      scrollable: true,
      focusNode: _focusNode,
      autoFocus: false,
      readOnly: true,
      placeholder: '',
      expands: false,
      padding: EdgeInsets.zero,
      customStyles: DefaultStyles(),
    );

    return quillEditor;
  }
}
