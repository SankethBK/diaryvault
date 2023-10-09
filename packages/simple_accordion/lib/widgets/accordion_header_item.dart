import 'package:flutter/material.dart';
import 'package:simple_accordion/model/simple_accordion_state.dart';
import 'package:simple_accordion/widgets/accordion_item.dart';

// ignore: must_be_immutable
class AccordionHeaderItem extends StatefulWidget {
  AccordionHeaderItem(
      {this.isOpen,
      Key? key,
      this.title,
      required this.children,
      this.child,
      this.headerColor,
      this.index = 0,
      this.headerTextStyle,
      this.itemTextStyle,
      this.itemColor})
      : assert(title != null || child != null),
        super(key: key);

  /// set default state of header (open/close)
  final bool? isOpen;
  final String? title;
  final Widget? child;
  final List<AccordionItem> children;

  /// set the color of header
  Color? headerColor;

  /// set the color of current header items
  Color? itemColor;

  /// don't use this property, it'll use to another feature
  int index;

  /// if you're using title instead of child in AccordionHeaderItem
  TextStyle? headerTextStyle;

  /// if you're using title instead of child in AccordionItem
  TextStyle? itemTextStyle;

  @override
  State<StatefulWidget> createState() => _AccordionHeaderItem();
}

class _AccordionHeaderItem extends State<AccordionHeaderItem> {
  late bool isOpen;

  @override
  void initState() {
    isOpen = widget.isOpen ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = SimpleAccordionState.of(context);
    final header = InkWell(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.child ??
              Text(
                widget.title!,
                style: widget.headerTextStyle,
              ),
          Icon(
            isOpen
                ? Icons.keyboard_arrow_up_outlined
                : Icons.keyboard_arrow_down_outlined,
            color: widget.headerColor,
          )
        ],
      ),
    );
    return AnimatedCrossFade(
      crossFadeState:
          isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
      firstChild: header,
      secondChild: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          Container(
            padding: const EdgeInsets.only(top: 6.0),
            color: widget.itemColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children
                  .map((e) => e
                    ..indexGroup = widget.index
                    ..checked = e.checked ??
                        (state?.selectedItems ?? [])
                            .any((w) => w.title == e.title)
                    ..itemTextStyle = e.itemTextStyle ?? widget.itemTextStyle)
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
