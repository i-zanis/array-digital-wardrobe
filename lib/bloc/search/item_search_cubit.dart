import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/main_development.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemSearchCubit extends Cubit<List<Item>> {
  ItemSearchCubit(this.itemBloc) : super(itemBloc.state.items) {
    logger.i('SearchItemCubit created');
  }

  late ItemBloc itemBloc;

  void refresh(BuildContext context) {
    late final itemBloc = context.read<ItemBloc>();
    emit(itemBloc.state.items);
  }

  void filterItems(BuildContext context, String query) {
    itemBloc = context.read<ItemBloc>();
    final filteredItems = itemBloc.state.items
        .where((item) => itemContainsQuery(item, query))
        .toList();

    emit(filteredItems);
  }

// Check if the item's name or any of its tags contain the query
// (case insensitive)
  bool itemContainsQuery(Item item, String query) {
    final lowerCaseQuery = query.toLowerCase();
    // Check name in query
    final nameContainsQuery =
        item.name?.toLowerCase().contains(lowerCaseQuery) ?? false;
    if (nameContainsQuery) {
      return true;
    }
    // Check tag in Tags
    final tagContainsQuery = item.tags?.any(
          (tag) => tag.name?.toLowerCase().contains(lowerCaseQuery) ?? false,
        ) ??
        false;
    return tagContainsQuery;
  }

  void clear(BuildContext context) {
    logger.i('$ItemSearchCubit: clear $state');
    emit(itemBloc.state.items);
  }
}
