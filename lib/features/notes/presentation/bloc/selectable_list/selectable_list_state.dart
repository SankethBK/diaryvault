part of 'selectable_list_cubit.dart';

abstract class SelectableListState extends Equatable {
  // We'll store ID's of selected items which are stirngs
  final List<String> selectedItems;

  const SelectableListState({required this.selectedItems});

  @override
  List<Object> get props => [selectedItems];
}

class SelectableListDisabled extends SelectableListState {
  const SelectableListDisabled({required List<String> selectedItems})
      : super(selectedItems: selectedItems);

  @override
  List<Object> get props => [selectedItems];
}

class SelectableListEnabled extends SelectableListState {
  const SelectableListEnabled({required List<String> selectedItems})
      : super(selectedItems: selectedItems);

  @override
  List<Object> get props => [selectedItems];
}
