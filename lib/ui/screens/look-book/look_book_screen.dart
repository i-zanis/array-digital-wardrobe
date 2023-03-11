import 'package:Array_App/ui/widget/button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/search/search_cubit.dart';
import '../../../domain/entity/item/item.dart';
import '../../widget/bottom_nav_bar.dart';

class LookBookScreen extends StatelessWidget {
  const LookBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemBloc = context.read<ItemBloc>();
    final searchCubit = context.read<SearchCubit>()..clear(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Text("Title"),
          Text("Subtitle"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                if (value.isEmpty) {
                  searchCubit.clear(context);
                } else {
                  searchCubit.filterItems(context, value);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, List<Item>>(
              builder: (context, state) {
                return state.isEmpty
                    ? const Center(child: Text('No items found'))
                    : Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _latestItemWidget(state),
                          ],
                        ),
                      );
              },
            ),
          ),
          ActionButton(onPressed: _matchStyle, icon: Icons.add),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _latestItemWidget(List<Item> items) {
    if (items.isEmpty) {
      return const Center(child: Text('No items found'));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(""),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          children: List.generate(
            items.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey,
                  child: Text(items[index].name ?? "no name"),
                ),
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
