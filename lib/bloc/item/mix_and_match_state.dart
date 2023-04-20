import 'package:Array_App/domain/entity/entity.dart';

class MixAndMatchState {
  MixAndMatchState({required this.items, required this.selectedItem});
  final List<Item> items;
  final Item selectedItem;

  MixAndMatchState copyWith({List<Item>? items, Item? selectedItem}) {
    return MixAndMatchState(
      items: items ?? this.items,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}
