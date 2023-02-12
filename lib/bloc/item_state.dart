import 'package:Array_App/domain/entity/item.dart';
import 'package:equatable/equatable.dart';

// TODO(jtl): Maybe needs to be abstract
class ItemState extends Equatable {
  const ItemState(
      {this.items = const [], this.selectedItemIndex = 0, this.exception});

  const ItemState._({
    this.items = const [],
    this.selectedItemIndex = 0,
    this.exception,
  });

  const ItemState.initial() : this._();
  final List<Item> items;
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
    int? selectedItemIndex,
    Exception? exception,
  }) {
    return ItemState(
      items: items ?? this.items,
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      exception: exception ?? this.exception,
    );
  }
}

class ItemLoaded extends ItemState {
  const ItemLoaded({required super.items}) : super._();
}

class ItemLoadFailure extends ItemState {
  const ItemLoadFailure(Exception exception) : super._(exception: exception);
}

class ItemError extends ItemState {
  const ItemError(Exception error) : super._(exception: error);
}

class ItemLoading extends ItemState {
  const ItemLoading({required super.items}) : super._();
}
