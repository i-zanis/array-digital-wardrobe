import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/main_development.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LookSearchCubit extends Cubit<List<Look>> {
  LookSearchCubit(this.itemBloc) : super(itemBloc.state.looks) {
    logger.i('LookSearchCubit created');
  }

  final ItemBloc itemBloc;

  void refresh(BuildContext context) {
    late final itemBloc = context.read<ItemBloc>();
    emit(itemBloc.state.looks);
  }

  void filterItems(BuildContext context, String query) {
    late final itemBloc = context.read<ItemBloc>();
    logger.i('$LookSearchCubit: filterItems ${itemBloc.state.looks.length}');
    final filteredLooks = itemBloc.state.looks
        .where((look) => lookContainsQuery(look, query))
        .toList();
    emit(filteredLooks);
  }

  // Check if the look's name, description, or lookImageData contain the query
  // (case insensitive)
  bool lookContainsQuery(Look look, String query) {
    final lowerCaseQuery = query.toLowerCase();

    final nameContainsQuery =
        look.name?.toLowerCase().contains(lowerCaseQuery) ?? false;
    final descriptionContainsQuery =
        look.description?.toLowerCase().contains(lowerCaseQuery) ?? false;

    return nameContainsQuery || descriptionContainsQuery;
  }

  void clear(BuildContext context) {
    logger.i('$LookSearchCubit: clear $state');
    emit(itemBloc.state.looks);
  }
}
