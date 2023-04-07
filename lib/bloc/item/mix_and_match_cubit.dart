import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/main_development.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../core/route/app_route.dart';
import '../../rest/util/util_functions.dart';

class MixAndMatchCubit extends Cubit<List<Item>> {
  MixAndMatchCubit() : super([]);

  // Adds an item to the state if its category is not already present
  void addItem(Item item) {
    logger.i('MixAndMatch addItem: ${item.name}');
    if (hasCategory(item.category)) {
      emit([...state, item]);
    }
    logger.d('state: $state');
  }

  // Removes an item from the state based on its category
  void removeItem(Item item) {
    logger.i('MixAndMatch removeItemByCategory: ${item.name}');
    final category = item.category;
    final updatedItems = state.where((i) => i.category != category).toList();
    emit(updatedItems);
  }

  // Checks if the state does not contain an item with the given category
  bool hasCategory(Category? category) {
    if (category == null) return false;
    return !state.any((i) => i.category == category);
  }

  void replaceItemAndNavigate(Item item, VoidCallback nextScreen) {
    removeItem(item);
    addItem(item);
    nextScreen();
  }

  // Clears the state
  void clear() {
    emit([]);
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
    if (state.isEmpty) {
      showSnackBar(context, snackBarContent);
    } else {
      emit([...state]);
      AppNavigator.push<void>(AppRoute.mixAndMatchResult);
    }
  }
}
