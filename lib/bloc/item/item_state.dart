import 'package:Array_App/domain/entity/entity.dart';
import 'package:equatable/equatable.dart';

// TODO(jtl): Maybe needs to be abstract
class ItemState extends Equatable {
  const ItemState({
    this.items = const [],
    this.looks = const [],
    this.itemToAdd,
    this.lookToAdd,
    this.selectedItemIndex = 0,
    this.exception,
  });

  const ItemState._({
    this.items = const [],
    this.looks = const [],
    this.itemToAdd,
    this.lookToAdd,
    this.selectedItemIndex = 0,
    this.exception,
  });

  const ItemState.initial() : this._();

  final List<Item> items;
  final List<Look> looks;
  final Item? itemToAdd;
  final Look? lookToAdd;
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
        looks,
        itemToAdd,
        lookToAdd,
        selectedItemIndex,
        exception,
      ];

  ItemState copyWith({
    List<Item>? items,
    List<Look>? looks,
    Item? itemToAdd,
    Look? lookToAdd,
    int? selectedItemIndex,
    Exception? exception,
  }) {
    return ItemState(
      items: items ?? this.items,
      looks: looks ?? this.looks,
      itemToAdd: itemToAdd ?? this.itemToAdd,
      lookToAdd: lookToAdd ?? this.lookToAdd,
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      exception: exception ?? this.exception,
    );
  }
}

class ItemLoaded extends ItemState {
  const ItemLoaded({
    required super.items,
    required super.looks,
    super.itemToAdd,
    super.lookToAdd,
  }) : super._();
}

class ItemLocalLoaded extends ItemState {
  const ItemLocalLoaded({
    required super.items,
    required super.looks,
    super.itemToAdd,
    super.lookToAdd,
  }) : super._();
}

class ItemLoadFailure extends ItemState {
  ItemLoadFailure(Exception exception) : super._(exception: exception) {}
}

class ItemError extends ItemState {
  const ItemError(Exception exception) : super._(exception: exception);
}

class ItemLoading extends ItemState {
  const ItemLoading({required super.items, required super.looks}) : super._();
}
