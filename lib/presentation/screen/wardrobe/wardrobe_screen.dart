import 'package:Array_App/bloc/search/item_search_cubit.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/widget/item_grid_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/style_config.dart';
import '../../../domain/entity/entity.dart';
import '../../widget/constant/box.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/search_bar.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  late ItemSearchCubit searchCubit;
  final List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    searchCubit = context.read<ItemSearchCubit>();
  }

  void _onCategorySelected(Category category) {
    setState(() {
      if (categories.contains(category)) {
        categories.remove(category);
      } else {
        categories.add(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = Theme.of(context).colorScheme.onSurface;
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: titleColor,
          fontWeight: FontWeight.bold,
        );
    final subtitleStyle = Theme.of(context).textTheme.titleSmall?.apply(
          color: subtitleColor,
        );
    final textStyleTop = Theme.of(context).textTheme.bodyLarge?.apply(
          color: titleColor,
        );
    final textStyleBottom = Theme.of(context).textTheme.titleMedium?.apply(
          color: subtitleColor,
        );
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.wardrobeScreenTitle,
        subtitle: l10n.wardrobeScreenSubtitle,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultMargin),
          child: Column(
            children: [
              _searchBar(l10n),
              Box.h8,
              _categoryList(),
              _itemList(searchCubit),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(AppLocalizations l10n) {
    return CustomSearchBar(
      searchCubit: searchCubit,
      hintText: l10n.lookBookScreenSearchBarHint,
    );
  }

  Widget _categoryList() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Category.values.length,
        itemBuilder: (BuildContext context, int index) {
          final category = Category.values[index];
          final categoryName = category.toString().split('.').last;
          final isSelected = categories.contains(category);
          return InkWell(
            onTap: () => _onCategorySelected(category),
            child: Padding(
              padding: const EdgeInsets.all(Styles.marginS),
              child: Column(
                children: [
                  Text(categoryName),
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: categoryName.length * 8.5,
                      height: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _itemList(ItemSearchCubit cubit) {
    return BlocBuilder<ItemSearchCubit, List<Item>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const Column(
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Center(child: Text('No items found')),
            ],
          );
        }
        List<Item> items;
        if (categories.isNotEmpty) {
          items = state
              .where((item) => categories.contains(item.category))
              .toList();
        } else {
          items = state;
        }
        return ItemGridProvider(items: items);
      },
    );
  }
}
