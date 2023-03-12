import 'package:Array_App/domain/entity/item/item.dart';
import 'package:equatable/equatable.dart';

// TODO(jtl): Maybe needs to be abstract
class ItemState extends Equatable {
  const ItemState({
    this.items = const [],
    this.itemToAdd,
    this.selectedItemIndex = 0,
    this.exception,
  });

  const ItemState._({
    this.items = const [],
    this.itemToAdd,
    this.selectedItemIndex = 0,
    this.exception,
  });

  const ItemState.initial() : this._();

  final List<Item> items;
  final Item? itemToAdd;
  final int selectedItemIndex;
  final Exception? exception;

  Item? get selectedItem {
    if (items.isEmpty) {
      return null;
    }
    return items[selectedItemIndex];
  }

  @override
  List<Object?> get props => [
        items,
        selectedItemIndex,
        exception,
      ];

  ItemState copyWith({
    List<Item>? items,
    Item? itemToAdd,
    int? selectedItemIndex,
    Exception? exception,
  }) {
    return ItemState(
      items: items ?? this.items,
      itemToAdd: itemToAdd ?? this.itemToAdd,
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      exception: exception ?? this.exception,
    );
  }
}

class ItemLoaded extends ItemState {
  const ItemLoaded({required super.items, super.itemToAdd}) : super._();
}

class ItemLoadFailure extends ItemState {
  const ItemLoadFailure(Exception exception) : super._(exception: exception);
}

class ItemError extends ItemState {
  const ItemError(Exception exception) : super._(exception: exception);
}

class ItemLoading extends ItemState {
  const ItemLoading({required super.items}) : super._();
}
