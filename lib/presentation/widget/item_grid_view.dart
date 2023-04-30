import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/bloc/item/item_state.dart';
import 'package:Array_App/bloc/item/mix_and_match_cubit.dart';
import 'package:Array_App/bloc/item/mix_and_match_state.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/widget/indicator/custom_linear_progress_indicator.dart';
import 'package:Array_App/presentation/widget/item_grid_provider.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemGridView extends StatelessWidget {
  const ItemGridView({
    super.key,
    this.numOfItemsToShow,
    this.isSelectionMode = false,
  });

  final int? numOfItemsToShow;
  final bool isSelectionMode;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MixAndMatchCubit>();
    final l10n = context.l10n;
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocConsumer<ItemBloc, ItemState>(
            builder: (context, state) {
              final items = _filterItems(state, cubit.state);
              if (state is ItemLoading) {
                return const CustomLinearProgressIndicator();
              } else if (state is ItemLoaded) {
                return ItemGridProvider(
                  items: items,
                  isSelectionMode: isSelectionMode,
                );
              } else if (state is ItemError) {
                return ItemGridProvider(
                  items: items,
                  isSelectionMode: isSelectionMode,
                );
              }
              return ItemGridProvider(
                items: items,
                isSelectionMode: isSelectionMode,
              );
            },
            listener: (context, state) {
              if (state is ItemError) {
                showSnackBar(context, l10n.itemLoadError);
              }
            },
          ),
        ],
      ),
    );
  }

  List<Item> _filterItems(ItemState state, MixAndMatchState cubitState) {
    List<Item> filteredItems;
    final selectedItem = cubitState.selectedItem;
    final category = selectedItem.category;
    if (category != null) {
      filteredItems =
          state.items.where((item) => item.category == category).toList();
    } else {
      filteredItems = state.items;
    }
    // Show newest first and limit the number of items to display
    final displayNum = numOfItemsToShow ?? filteredItems.length;
    final updatedItems = filteredItems.reversed.take(displayNum).toList();
    return updatedItems;
  }
}
