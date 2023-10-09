import 'package:flutter/material.dart';
import 'package:simple_accordion/model/SimpleAccordionState.dart';
import 'package:simple_accordion/widgets/AccordionHeaderItem.dart';

class SimpleAccordion extends StatefulWidget {
  const SimpleAccordion(
      {Key? key,
      required this.children,
      this.headerColor,
      this.itemColor,
      this.maxSelectCount,
      this.headerTextStyle,
      this.itemTextStyle,
      this.selectedItems,
      this.onSelectedChanged})
      : super(key: key);

  final List<AccordionHeaderItem> children;

  /// background color of all headers
  final Color? headerColor;

  /// background color of all items
  final Color? itemColor;

  /// Maximum possible select for checkbox items
  final int? maxSelectCount;

  /// if you're using title instead of child in AccordionHeaderItem
  final TextStyle? headerTextStyle;

  /// if you're using title instead of child in AccordionItem
  final TextStyle? itemTextStyle;

  /// when a checkbox item state changed, it returns all the seleced items
  final Function(List<AccordionData>)? onSelectedChanged;

  // set default selected items
  final List<AccordionData>? selectedItems;

  @override
  State<SimpleAccordion> createState() => _SimpleAccordionState();
}

class _SimpleAccordionState extends State<SimpleAccordion> {
  @override
  Widget build(BuildContext context) {
    int i = 0;
    return SimpleAccordionState(
      selectedItems: widget.selectedItems ?? [],
      onSelectedChanged: widget.onSelectedChanged,
      maxSelectedCount: widget.maxSelectCount,
      child: SingleChildScrollView(
        child: Column(
          children: widget.children
              .map((e) => e
                ..headerColor = e.headerColor ?? widget.headerColor
                ..index = i++
                ..itemTextStyle = e.itemTextStyle ?? widget.itemTextStyle
                ..headerTextStyle = e.headerTextStyle ?? widget.headerTextStyle
                ..itemColor = e.itemColor ?? widget.itemColor)
              .toList(),
        ),
      ),
    );
  }
}
