import 'package:equatable/equatable.dart';

import '../domain/entity/item.dart';

// TODO(jtl): Maybe needs to be abstract
class ItemState extends Equatable {
  const ItemState._({
    this.status = ItemStateStatus.initial,
    this.items = const [],
    this.selectedItemIndex = 0,
    this.page = 1,
    this.error,
  });

  const ItemState.initial() : this._();
  final ItemStateStatus status;
  final List<Item> items;
  final int selectedItemIndex;
  final int page;
  final Exception? error;

  Item get selectedItem {
    if (items.isEmpty) {
      // return Item(null, null, null, null, null, null, null, null);
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
      page: 1,
    );
  }

  ItemState asSaveSuccess(Item item) {
    return copyWith(
      status: ItemStateStatus.loadSuccess,
      items: [...items, item],
    );
  }

  ItemState asUpdateSuccess(Item item) {
    final filteredItems = items.where((i) => item.id != i.id).toList();
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

  ItemState asLoadingMore() {
    return copyWith(status: ItemStateStatus.loadingMore);
  }

  ItemState asLoadMoreSuccess(List<Item> newItems, {bool canLoadMore = true}) {
    return copyWith(
      status: ItemStateStatus.loadMoreSuccess,
      items: [...items, ...newItems],
      page: canLoadMore ? page + 1 : page,
      canLoadMore: canLoadMore,
    );
  }

  ItemState asLoadMoreFailure(Exception e) {
    return copyWith(
      status: ItemStateStatus.loadMoreFailure,
      error: e,
    );
  }

  ItemState copyWith({
    ItemStateStatus? status,
    List<Item>? items,
    int? selectedPokemonIndex,
    int? page,
    bool? canLoadMore,
    Exception? error,
  }) {
    return ItemState._(
      status: status ?? this.status,
      items: items ?? this.items,
      selectedItemIndex: selectedItemIndex,
      page: page ?? this.page,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        selectedItemIndex,
        page,
        error,
      ];
}

enum ItemStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  loadingMore,
  loadMoreSuccess,
  loadMoreFailure,
}

// class ItemLoading extends ItemState {
//   const ItemLoading.initial() : super.initial();
// }
//
// class ItemLoaded extends ItemState {
//   const ItemLoaded.initial() : super.initial();
// }
