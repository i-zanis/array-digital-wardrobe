import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/item/item_state.dart';
import 'indicator/custom_linear_progress_indicator.dart';
import 'look_grid_provider.dart';

class LookGridView extends StatelessWidget {
  const LookGridView({
    super.key,
    this.numOfItemsToShow,
    this.isSelectionMode = false,
  });

  final int? numOfItemsToShow;
  final bool isSelectionMode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              final looks = state.looks.reversed.take(2).toList();
              if (state is ItemLoading) {
                return const CustomLinearProgressIndicator();
              } else if (state is ItemLoaded) {
                return LookGridProvider(looks: looks, isLooks: true);
              } else if (state is ItemError) {
                return LookGridProvider(looks: looks, isLooks: true);
              }
              return LookGridProvider(looks: state.looks, isLooks: true);
            },
          ),
        ],
      ),
    );
  }
}
