import 'package:flutter/material.dart';
import 'package:simple_accordion/model/SimpleAccordionState.dart';

enum AccrodionItemType { Label, CheckBox }

class AccordionItem extends StatefulWidget {
  AccordionItem(
      {Key? key,
      this.id,
      this.title,
      this.child,
      this.onChange,
      this.checked,
      this.indexGroup = 0,
      this.onTap,
      this.checkColor,
      this.itemColor,
      this.itemTextStyle,
      this.accrodionItemType = AccrodionItemType.Label})
      : assert(title != null || child != null),
        super(key: key);
  final String? id;
  final String? title;
  final Widget? child;

  /// if you're using title instead of child in AccordionItem
  TextStyle? itemTextStyle;

  /// hanle tap for item
  final Function()? onTap;

  /// hanlde the check state of checkbox item
  final Function(bool, AccordionData?)? onChange;

  /// default state of checkbox item
  bool? checked;

  /// check color of checkbox item
  final Color? checkColor;

  /// background color of the item
  final Color? itemColor;

  /// don't use this property, it'll use to another feature
  int indexGroup;

  /// set the type of item (checkbox, label), lable can be everything
  final AccrodionItemType accrodionItemType;
  @override
  State<StatefulWidget> createState() => _AccordionItem();
}

class _AccordionItem extends State<AccordionItem> {
  late bool checked;
  @override
  void initState() {
    checked = widget.checked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ??
        ListTile(
          tileColor: widget.itemColor,
          title: Text(
            widget.title!,
            style: widget.itemTextStyle ??
                TextStyle(
                    color: Theme.of(context).textTheme.headline1?.color,
                    fontSize: 13),
          ),
          trailing: widget.accrodionItemType == AccrodionItemType.CheckBox
              ? AnimatedCrossFade(
                  crossFadeState: checked
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 50),
                  firstChild: Icon(
                    Icons.check,
                    color: widget.checkColor,
                  ),
                  secondChild: const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                )
              : const SizedBox(),
          visualDensity: VisualDensity.compact,
          onTap: widget.onTap ??
              () {
                if (widget.accrodionItemType == AccrodionItemType.CheckBox) {
                  SimpleAccordionState state =
                      SimpleAccordionState.of(context)!;
                  if (state.selectedItems.length >=
                          (state.maxSelectedCount ?? 1000) &&
                      !checked) {
                    return;
                  }
                  setState(() {
                    checked = !checked;
                  });
                  if (checked) {
                    state.selectedItems
                        .add(AccordionData(id: widget.id, title: widget.title));
                  } else {
                    state.selectedItems
                        .removeWhere((a) => a.title == widget.title);
                  }

                  if (state.onSelectedChanged != null) {
                    state.onSelectedChanged!(state.selectedItems);
                  }
                  if (widget.onChange != null) {
                    widget.onChange!(checked,
                        AccordionData(id: widget.id, title: widget.title));
                  }
                }
              },
        );
  }
}
