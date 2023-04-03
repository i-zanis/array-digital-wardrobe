import 'package:Array_App/bloc/search/search_cubit.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/route/app_navigator.dart';
import '../../../core/route/app_route.dart';
import 'latest_item_widget.dart';
import 'search_bar.dart';

class LookBookScreen extends StatefulWidget {
  const LookBookScreen({super.key});

  @override
  State createState() => _LookBookScreenState();
}

class _LookBookScreenState extends State<LookBookScreen> {
  late SearchCubit searchCubit;

  @override
  void initState() {
    super.initState();
    searchCubit = context.read<SearchCubit>();
  }

  @override
  Widget build(BuildContext context) {
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
              _searchBar(l10n),
              _latestLookSection(l10n, titleStyle, subtitleStyle, titleColor),
              _itemList(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(AppLocalizations l10n) {
    return SearchBar(
      searchCubit: searchCubit,
      onQueryChanged: (value) {
        if (value.isEmpty) {
          searchCubit.clear(context);
        } else {
          searchCubit.filterItems(context, value);
        }
      },
      hintText: l10n.lookBookScreenSearchBarHint,
    );
  }

  Widget _latestLookSection(
    AppLocalizations l10n,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    Color? titleColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(StyleConfig.defaultMargin),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.latestLookTitle, style: titleStyle),
              Row(
                children: [
                  Icon(Icons.favorite_outline, color: titleColor),
                  Text(l10n.seeFavouriteItem, style: subtitleStyle),
                ],
              ),
            ],
          ),
          const Spacer(),
          FloatingActionButton(
            heroTag: l10n.mixAndMatch,
            onPressed: () => AppNavigator.push<void>(AppRoute.mixAndMatchPick),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  Widget _itemList() {
    return BlocBuilder<SearchCubit, List<Item>>(
      builder: (context, state) {
        return state.isEmpty
            ? const Center(child: Text('No items found'))
            : Padding(
                padding: const EdgeInsets.only(
                  left: StyleConfig.defaultMargin,
                  right: StyleConfig.defaultMargin,
                ),
                child: LatestLookWidget(items: state),
              );
      },
    );
  }
}
