import 'package:Array_App/bloc/item/mix_and_match_state.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/main_development.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MixAndMatchCubit extends Cubit<MixAndMatchState> {
  MixAndMatchCubit()
      : super(MixAndMatchState(items: [], selectedItem: Item.empty()));

  // Adds an item to the state if its category is not already present
  void addItem(Item item) {
    logger.i('MixAndMatch addItem: ${item.name}');
    if (isCategoryAbsent(item.category)) {
      emit(state.copyWith(items: [...state.items, item]));
    }
    logger
      ..d('state: $state')
      ..d('length: ${state.items.length}');
  }

  // Removes an item from the state based on its category
  void removeItem(Item item) {
    logger.i('MixAndMatch removeItemByCategory: ${item.name}');
    final category = item.category;
    final updatedItems =
        state.items.where((i) => i.category != category).toList();
    emit(state.copyWith(items: updatedItems));
  }

  bool isCategoryAbsent(Category? category) {
    if (category == null) return false;
    return !state.items.any((i) => i.category == category);
  }

  void replaceItemAndNavigate(Item item, VoidCallback nextScreen) {
    removeItem(item);
    addItem(item);
    nextScreen();
  }

  void selectItem(Item item) {
    logger.i('MixAndMatch selectItem: ${item}');
    emit(state.copyWith(selectedItem: item));
  }

  // Clears the state
  void clear() {
    emit(state.copyWith(items: [], selectedItem: Item.empty()));
  }

  // Clears the state and pops the current screen
  IconButton popAndClear(BuildContext context) {
    clear();
    return const IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: AppNavigator.pop,
    );
  }

  void selectItemsAndNextScreen(BuildContext context, String snackBarContent) {
    if (state.items.isEmpty) {
      showSnackBar(context, snackBarContent);
    } else {
      emit(state);
      AppNavigator.push<void>(AppRoute.mixAndMatchResult);
    }
  }
}
