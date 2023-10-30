import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/chip_theme_extensions.dart';
import 'package:flutter/material.dart';

class TagTextInput extends StatefulWidget {
  final void Function() onCancel;
  final void Function(String newTag) onSubmit;
  final bool autoFocus;
  const TagTextInput({
    Key? key,
    required this.onCancel,
    required this.onSubmit,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  State<TagTextInput> createState() => _TagTextInputState();
}

class _TagTextInputState extends State<TagTextInput> {
  final TextEditingController _textController = TextEditingController();

  final FocusNode textfieldFocus = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    textfieldFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    textfieldFocus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fillColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.backgroundColor;

    final iconColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.iconColor;

    final textColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.textColor;

    final borderColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.borderColor;

    return TextField(
      focusNode: textfieldFocus,
      controller: _textController,
      autofocus: widget.autoFocus,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.5, horizontal: 5),
        prefix: IconButton(
          onPressed: () {
            widget.onCancel();
            _textController.clear();
          },
          padding: const EdgeInsets.all(0),
          icon: Icon(Icons.cancel, size: 20, color: iconColor),
        ),
        suffix: IconButton(
          onPressed: () {
            final newTag = _textController.text;
            widget.onSubmit(newTag);
            _textController.clear();
            widget.onCancel();
          },
          icon: Icon(
            Icons.check,
            size: 20,
            color: iconColor,
          ),
        ),
        fillColor: fillColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: borderColor,
            width: 0.7,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
      ),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
    );
  }
}
