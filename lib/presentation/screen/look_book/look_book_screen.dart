import 'package:Array_App/bloc/search/search_cubit.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/route/app_navigator.dart';
import '../../../core/route/app_route.dart';
import '../../../domain/entity/item/look.dart';
import '../../../main_development.dart';

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
          padding: const EdgeInsets.all(Styles.defaultMargin),
          child: Column(
            children: [
              _searchBar(l10n),
              Box.h32,
              _latestLookSection(l10n, titleStyle, subtitleStyle, titleColor),
              Box.h8,
              _itemList(),
              const BottomMargin()
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

  Widget _latestLookSection(
    AppLocalizations l10n,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    Color? titleColor,
  ) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.latestLookTitle,
              style: titleStyle,
            ),
            Box.h4,
            InkWell(
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_circle_right_outlined,
                    color: titleColor,
                  ),
                  Box.w4,
                  Text(
                    l10n.seeFavouriteLook,
                    style: subtitleStyle,
                  ),
                ],
              ),
              // TODO(jtl): fix tap method
              onTap: () => AppNavigator.push<dynamic>(AppRoute.itemProfile),
            ),
          ],
        ),
        const Spacer(),
        //todo(jtl): add favourite screen and change route
        PlusButton(
          onPressed: () => AppNavigator.push<void>(
            AppRoute.selectItemInGrid,
          ),
          heroTag: l10n.mixAndMatchScreenTitle,
        ),
      ],
    );
  }

  Widget _itemList() {
    return BlocBuilder<SearchCubit, List<Item>>(
      builder: (context, state) {
        final filteredItems = <Item>[];
        final currentLooks = <Look>[];
        for (final item in state) {
          if (item.looks != null) {
            for (final look in item.looks!) {
              if (!currentLooks.contains(look)) {
                currentLooks.add(look);
                filteredItems.add(item);
              }
            }
          }
        }
        logger
          ..d('filteredLooks: $currentLooks')
          ..d('filteredItems: $filteredItems');
        return state.isEmpty
            ? Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  Text(
                    'No looks found',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              )
            : ItemGridProvider(items: state, isLooks: true);
      },
    );
  }
}
