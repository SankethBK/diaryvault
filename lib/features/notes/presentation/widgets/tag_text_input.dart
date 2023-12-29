import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/chip_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
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
  late TextEditingController _textController;

  List<String> allTags = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    sl<INotesRepository>().getAllTags().then((value) {
      setState(() {
        allTags = value;
      });
    });
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

    final barrierColor =
        Theme.of(context).extension<PopupThemeExtensions>()!.barrierColor;
    print("allTags = $allTags");

    return Autocomplete<String>(
      optionsBuilder: (textEditingValue) {
        return allTags.where((entry) => entry.contains(textEditingValue.text));
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 1.0,
            color: barrierColor,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 216),
              child: SizedBox(
                height: options.length * 32,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          option,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      onSelected: (String? tag) {
        print("onSelected tag = $tag");
        if (tag != null) {
          widget.onSubmit(tag);
          _textController.clear();
          widget.onCancel();
        }
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        focusNode.requestFocus();
        _textController = controller;

        return TextField(
          focusNode: focusNode,
          controller: controller,
          autofocus: widget.autoFocus,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.5, horizontal: 5),
            prefix: IconButton(
              onPressed: () {
                widget.onCancel();
                controller.clear();
              },
              padding: const EdgeInsets.all(0),
              icon: Icon(Icons.cancel, size: 20, color: iconColor),
            ),
            suffix: IconButton(
              onPressed: () {
                final newTag = controller.text;
                widget.onSubmit(newTag);
                controller.clear();
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
      },
    );
  }
}
