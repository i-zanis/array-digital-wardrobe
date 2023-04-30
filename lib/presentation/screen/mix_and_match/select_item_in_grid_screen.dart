import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/bloc/item/mix_and_match_cubit.dart';
import 'package:Array_App/bloc/item/mix_and_match_state.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/item/category.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/screen/mix_and_match/category_box.dart';
import 'package:Array_App/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectItemInGridScreen extends StatefulWidget {
  const SelectItemInGridScreen({super.key, this.isFromCameraScreen});

  final Object? isFromCameraScreen;

  @override
  State createState() => _SelectItemInGridScreenState();
}

class _SelectItemInGridScreenState extends State<SelectItemInGridScreen> {
  List<Item> initialItems = [
    Item(category: Category.TOP),
    Item(category: Category.BOTTOM),
    Item(category: Category.SHOES),
    Item(category: Category.ACCESSORIES),
    Item(category: Category.INNERWEAR),
    Item(category: Category.OTHER),
  ];
  late final MixAndMatchCubit cubit;
  bool isFromCameraScreen = false;

  @override
  void initState() {
    cubit = context.read<MixAndMatchCubit>();
    isFromCameraScreen =
        widget.isFromCameraScreen is bool && widget.isFromCameraScreen == true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: CustomAppBar(
        title: _title(),
        subtitle: _subtitle(),
        leading: _handleBackButton(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Styles.defaultMargin),
        child: Column(
          children: [
            BlocBuilder<MixAndMatchCubit, MixAndMatchState>(
              builder: (context, state) {
                return categoryGrid(state.items);
              },
            ),
            const Spacer(),
            FilledButton(
              onPressed: () =>
                  _handleContinue(l10n.mixAndMatchNoCategorySelectedError),
              child: Text(l10n.mixAndMatchScreenButtonContinue),
            )
          ],
        ),
      ),
    );
  }

  String _subtitle() {
    if (isFromCameraScreen) {
      return context.l10n.itemProfileScreenItemCreationSubtitle;
    }
    return context.l10n.mixAndMatchScreenSubtitle;
  }

  String _title() {
    if (isFromCameraScreen) {
      return context.l10n.itemProfileScreenItemCreationTitle;
    }
    return context.l10n.mixAndMatchScreenTitle;
  }

  Widget categoryGrid(List<Item> selectableBoxes) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(6, (index) {
        final item = initialItems[index];
        final category = item.category ?? Category.TOP;
        return SelectableBox(
          category: category,
          isSelected: selectableBoxes.any((i) => i.category == category),
          onTap: () {
            _handleItemTap(selectableBoxes, category, item);
          },
        );
      }),
    );
  }

  void _handleItemTap(
    List<Item> selectableBoxes,
    Category category,
    Item item,
  ) {
    if (isFromCameraScreen && context.mounted) {
      final updatedItemToAdd =
          context.read<ItemBloc>().state.itemToAdd?.copyWith(
                    category: category,
                  ) ??
              Item(category: category);
      BlocProvider.of<ItemBloc>(context).add(UpdateItemToAdd(updatedItemToAdd));
      AppNavigator.push(AppRoute.root, arguments: 3);
    } else {
      if (selectableBoxes.any((i) => i.category == category)) {
        cubit.removeItem(item);
      } else {
        cubit.addItem(item);
      }
    }
  }

  void _handleContinue(String snackBarContent) {
    cubit.selectItemsAndNextScreen(context, snackBarContent);
  }

  Widget _handleBackButton(BuildContext context) {
    return cubit.popAndClear(context);
  }
}
