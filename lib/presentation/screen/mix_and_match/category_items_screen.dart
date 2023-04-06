import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/item/item_state.dart';
import '../../../bloc/item/mix_and_match_cubit.dart';
import '../../../domain/entity/item/category.dart';

class CategoryItemsScreen extends StatelessWidget {
  final Category selectedCategory;

  CategoryItemsScreen({required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Items'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          final items = state.items
              .where((item) => item.category == selectedCategory)
              .toList();
          return SingleChildScrollView(
            child: Column(
              children: items.map((item) {
                return ListTile(
                  title: Text(item?.name ?? 'No name'),
                  onTap: () {
                    context.read<MixAndMatchCubit>().addCategory(item);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
