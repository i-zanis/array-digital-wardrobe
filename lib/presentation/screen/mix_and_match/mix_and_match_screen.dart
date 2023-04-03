import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/item/category.dart';
import '../../widget/custom_app_bar.dart';
import 'category_box.dart';

class MixAndMatchScreen extends StatefulWidget {
  const MixAndMatchScreen({super.key});

  @override
  State createState() => _MixAndMatchScreenState();
}

class _MixAndMatchScreenState extends State<MixAndMatchScreen> {
  List<int> selectedBoxes = [];

  final boxText = <Category>[
    Category.TOP,
    Category.BOTTOM,
    Category.SHOES,
    Category.ACCESSORIES,
    Category.INNERWEAR,
    Category.OTHER,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.mixAndMatchScreenTitle,
        subtitle: l10n.mixAndMatchScreenSubtitle,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(StyleConfig.defaultMargin),
        child: Column(
          children: [
            _buildCategoryGrid(),
            const Spacer(),
            FilledButton(
              onPressed: () =>
                  _handleMatchStyle(l10n.mixAndMatchNoCategorySelectedError),
              child: Text(l10n.mixAndMatchScreenButtonContinue),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(6, (index) {
        return CategoryBox(
          category: boxText[index],
          isSelected: selectedBoxes.contains(index),
          onTap: () {
            setState(() {
              if (selectedBoxes.contains(index)) {
                selectedBoxes.remove(index);
              } else {
                selectedBoxes.add(index);
              }
            });
          },
        );
      }),
    );
  }

  void _handleMatchStyle(String snackBarContent) {
    if (selectedBoxes.isEmpty) {
      showSnackBar(context, snackBarContent);
    } else {
      final itemsToMoveToNextScreen = <Category>[];
      for (final index in selectedBoxes) {
        itemsToMoveToNextScreen.add(boxText[index]);
      }
      AppNavigator.push(
        AppRoute.mixAndMatchResult,
        arguments: itemsToMoveToNextScreen,
      );
    }
  }
}
