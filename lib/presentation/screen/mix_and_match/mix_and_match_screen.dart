import 'package:Array_App/bloc/item/mix_and_match_cubit.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/style_config.dart';
import '../../../domain/entity/item/category.dart';
import '../../../domain/entity/item/item.dart';
import '../../widget/custom_app_bar.dart';
import 'category_box.dart';

class MixAndMatchScreen extends StatefulWidget {
  const MixAndMatchScreen({super.key});

  @override
  State createState() => _MixAndMatchScreenState();
}

class _MixAndMatchScreenState extends State<MixAndMatchScreen> {
  List<Item> initialItems = [
    Item(category: Category.TOP),
    Item(category: Category.BOTTOM),
    Item(category: Category.SHOES),
    Item(category: Category.ACCESSORIES),
    Item(category: Category.INNERWEAR),
    Item(category: Category.OTHER),
  ];
  late final MixAndMatchCubit cubit;

  @override
  void initState() {
    cubit = context.read<MixAndMatchCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.mixAndMatchScreenTitle,
        subtitle: l10n.mixAndMatchScreenSubtitle,
        leading: _handleBackButton(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Styles.defaultMargin),
        child: Column(
          children: [
            BlocBuilder<MixAndMatchCubit, List<Item>>(
              builder: (context, state) {
                return categoryGrid(state);
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
            _handleAddCategory(selectableBoxes, category, item);
          },
        );
      }),
    );
  }

  void _handleAddCategory(
    List<Item> selectableBoxes,
    Category category,
    Item item,
  ) {
    if (selectableBoxes.any((i) => i.category == category)) {
      cubit.removeItem(item);
    } else {
      cubit.addItem(item);
    }
  }

  void _handleContinue(String snackBarContent) {
    cubit.selectItemsAndNextScreen(context, snackBarContent);
  }

  Widget _handleBackButton(BuildContext context) {
    return cubit.popAndClear(context);
  }
}
