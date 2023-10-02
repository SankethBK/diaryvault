import 'package:flutter/cupertino.dart';

class AccordionData {
  AccordionData({this.id, this.title, this.selected});
  String? id;
  String? title;
  List<AccordionData>? selected = [];
}

class SimpleAccordionState extends InheritedWidget {
  const SimpleAccordionState(
      {Key? key,
      required this.child,
      required this.selectedItems,
      this.onSelectedChanged,
      this.maxSelectedCount})
      : super(key: key, child: child);
  final Widget child;
  final List<AccordionData> selectedItems;
  final int? maxSelectedCount;
  final Function(List<AccordionData>)? onSelectedChanged;

  static SimpleAccordionState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SimpleAccordionState>();
  }

  @override
  bool updateShouldNotify(covariant SimpleAccordionState oldWidget) {
    return selectedItems != oldWidget.selectedItems;
  }
}
