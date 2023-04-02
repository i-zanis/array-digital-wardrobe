import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';

import '../../../core/route/app_route.dart';
import '../../widget/custom_app_bar.dart';
import 'mix_and_match_type.dart';

class MixAndMatchPickScreen extends StatefulWidget {
  const MixAndMatchPickScreen({super.key});

  @override
  State createState() => _MixAndMatchPickScreenState();
}

class _MixAndMatchPickScreenState extends State<MixAndMatchPickScreen> {
  List<int> selectedBoxes = [];

  final boxText = <Category>[
    Category.top,
    Category.bottom,
    Category.shoes,
    Category.accessories,
    Category.innerwear,
    Category.other,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final backgroundColors = <Color>[
      Theme.of(context).colorScheme.primaryContainer,
      Theme.of(context).colorScheme.secondaryContainer,
      Theme.of(context).colorScheme.tertiaryContainer
    ];
    final textColors = <Color>[
      Theme.of(context).colorScheme.onPrimaryContainer,
      Theme.of(context).colorScheme.onSecondaryContainer,
      Theme.of(context).colorScheme.onTertiaryContainer,
    ];

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
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(6, (index) {
                final boxColor = backgroundColors[index % 3];
                final text = boxText[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedBoxes.contains(index)) {
                        selectedBoxes.remove(index);
                      } else {
                        selectedBoxes.add(index);
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(StyleConfig.marginS),
                    decoration: BoxDecoration(
                      color: boxColor,
                      borderRadius: BorderRadius.circular(StyleConfig.radiusM),
                      border: selectedBoxes.contains(index)
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: StyleConfig.borderL,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        text.name.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: textColors[index % 3],
                            ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () =>
                  _handMatchStyle(l10n.mixAndMatchNoCategorySelectedError),
              child: Text(l10n.mixAndMatchScreenButtonContinue),
            ),
          ],
        ),
      ),
    );
  }

  void _handMatchStyle(String snackBarContent) {
    if (selectedBoxes.isEmpty) {
      showSnackBar(context, snackBarContent);
    } else {
      final itemsToMoveToNextScreen = <Category>[];
      for (final index in selectedBoxes) {
        itemsToMoveToNextScreen.add(boxText[index]);
      }
      // logger.d(itemsToMoveToNextScreen);
      AppNavigator.push(AppRoute.mixAndMatchResult, itemsToMoveToNextScreen);
      // Navigator.push(context, MixAndMatchPickScreen(itemsToMoveToNextScreen));
    }
  }
}
