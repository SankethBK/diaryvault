import 'package:dairy_app/app/themes/theme_extensions/chip_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/features/notes/presentation/widgets/tag_text_input.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class TagList extends StatefulWidget {
  final List<String> tags;
  final void Function(String newTag) addNewTag;
  final void Function(int index) removeTag;

  const TagList({
    required this.tags,
    required this.addNewTag,
    required this.removeTag,
    super.key,
  });

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  var showAddNewTagInput = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.backgroundColor;

    final deleteIconColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.iconColor;

    final textColor =
        Theme.of(context).extension<ChipThemeExtensions>()!.textColor;

    void closeTagTextInput() {
      setState(() {
        showAddNewTagInput = false;
      });
    }

    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.tags.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: showAddNewTagInput
                  ? SizedBox(
                      width: 180,
                      child: TagTextInput(
                        onSubmit: (String newTag) {
                          if (widget.tags.contains(newTag)) {
                            showToast(S.current.tagAlreadyExists);
                            return;
                          }

                          widget.addNewTag(newTag);
                        },
                        onCancel: closeTagTextInput,
                        autoFocus: true,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          showAddNewTagInput = true;
                        });
                      },
                      child: Chip(
                        label: Text(
                          "+",
                          style: TextStyle(color: textColor, fontSize: 23),
                        ),
                        backgroundColor: backgroundColor,
                      ),
                    ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Chip(
                label: Text(
                  widget.tags[index - 1],
                  style: TextStyle(color: textColor),
                ),
                backgroundColor: backgroundColor,
                deleteIconColor: deleteIconColor,
                onDeleted: () {
                  widget.removeTag(index - 1);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
