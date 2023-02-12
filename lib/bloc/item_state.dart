import 'package:equatable/equatable.dart';

import '../domain/entity/item.dart';

// TODO(jtl): Maybe needs to be abstract
class ItemState extends Equatable {
  const ItemState._({
    this.status = ItemStateStatus.initial,
    this.items = const [],
    this.selectedItemIndex = 0,
    this.error,
  });

  const ItemState.initial() : this._();
  final ItemStateStatus status;
  final List<Item> items;
  final int selectedItemIndex;
  final Exception? error;

  Item get selectedItem {
    if (items.isEmpty) {
      // return Item(null, null, null, null, null, null, null, null);
      // TODO(jtl): Fix this after testing period
      return Item(userId: 1);
    }
    return items[selectedItemIndex];
  }

  ItemState asLoading() {
    return copyWith(
      status: ItemStateStatus.loading,
    );
  }

  ItemState asLoadSuccess(List<Item> items) {
    return copyWith(
      status: ItemStateStatus.loadSuccess,
      items: items,
    );
  }

  ItemState asSaveSuccess(Item item) {
    return copyWith(
      status: ItemStateStatus.loadSuccess,
      items: [...items, item],
    );
  }

  ItemState asUpdateSuccess(Item item) {
    final filteredItems = items.where((i) => i.id != item.id).toList();
    return copyWith(
      status: ItemStateStatus.loadSuccess,
      items: [...filteredItems, item],
    );
  }

  ItemState asLoadFailure(Exception e) {
    return copyWith(
      status: ItemStateStatus.loadFailure,
      error: e,
    );
  }

  ItemState copyWith({
    ItemStateStatus? status,
    List<Item>? items,
    int? selectedItemIndex,
    Exception? error,
  }) {
    return ItemState._(
      status: status ?? this.status,
      items: items ?? this.items,
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        selectedItemIndex,
        error,
      ];
}

enum ItemStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
}

// class ItemLoading extends ItemState {
//   const ItemLoading.initial() : super.initial();
// }
//
// class ItemLoaded extends ItemState {
//   const ItemLoaded.initial() : super.initial();
// }
