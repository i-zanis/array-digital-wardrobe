import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/search/search_cubit.dart';
import '../../../config/style_config.dart';

class LookBookScreen extends StatelessWidget {
  const LookBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final searchCubit = context.read<SearchCubit>()..clear(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.lookBookScreenTitle,
        subtitle: l10n.lookBookScreenSubtitle,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(StyleConfig.defaultMargin),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(StyleConfig.defaultMargin),
                child: TextField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      searchCubit.clear(context);
                    } else {
                      searchCubit.filterItems(context, value);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: l10n.lookBookScreenSearchBarDescription,
                  ),
                ),
              ),
              BlocBuilder<SearchCubit, List<Item>>(
                builder: (context, state) {
                  return state.isEmpty
                      ? const Center(child: Text('No items found'))
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _latestItemWidget(context, state),
                            ],
                          ),
                        );
                },
              ),
              CustomActionButton(onPressed: _matchStyle, icon: Icons.add),
            ],
          ),
        ),
      ),
    );
  }

  Widget _latestItemWidget(BuildContext context, List<Item> items) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final l10n = context.l10n;
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = Theme.of(context).colorScheme.onSurface;
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.apply(
          color: titleColor,
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
    if (items.isEmpty) {
      return const Center(child: Text('No items found'));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 120,
          shrinkWrap: true,
          children: List.generate(
            items.length,
            (index) {
              var brand = items[index].brand ?? '';
              if (brand.isEmpty) brand = 'No brand';
              var name = items[index].name ?? '';
              if (name.isEmpty) name = 'No name';
              return Column(
                children: [
                  if (items[index].imageData != null)
                    Image(
                      width: double.infinity,
                      height: height * 0.25,
                      image: MemoryImage(
                        items[index].imageData!,
                      ),
                      // fit: BoxFit.fill,
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: height * 0.25,
                      color: Colors.grey,
                    ),
                  Text(brand, style: textStyleTop),
                  Text(
                    name,
                    style: textStyleBottom,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void _matchStyle() {}
}

class SearchBar extends StatelessWidget {
  const SearchBar(
      {super.key, required this.onQueryChanged, required this.searchCubit});

  final ValueChanged<String> onQueryChanged;
  final SearchCubit searchCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          searchCubit.filterItems(context, value);
        },
        decoration: InputDecoration(
          hintText: 'Search...',
        ),
      ),
    );
  }
}
