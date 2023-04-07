import 'package:Array_App/bloc/item/mix_and_match_cubit.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/main_development.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MixAndMatchResultScreen extends StatefulWidget {
  const MixAndMatchResultScreen({super.key});

  @override
  State createState() => _MixAndMatchResultScreenState();
}

class _MixAndMatchResultScreenState extends State<MixAndMatchResultScreen> {
  List<Item> selectedBoxes = [];

  final boxText = <Category>[
    Category.TOP,
    Category.BOTTOM,
    Category.SHOES,
    Category.ACCESSORIES,
    Category.INNERWEAR,
    Category.OTHER,
  ];

  late final MixAndMatchCubit cubit;

  @override
  void initState() {
    cubit = context.read<MixAndMatchCubit>();
    _generateBoxes();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultMargin),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(selectedBoxes.length, (index) {
                  final boxColor = backgroundColors[index % 3];
                  final category = selectedBoxes[index].category;
                  final text1 = selectedBoxes[index].category?.name;
                  final text2 = l10n.mixAndMatchAddFromWardrobe;
                  return GestureDetector(
                    onTap: () {
                      if (index.isOdd) {
                        AppNavigator.push(AppRoute.mixAndMatchCategoryItems);
                      }
                    },
                    child: index.isEven
                        ? leftGridItem(
                            boxColor, index, context, text1, textColors)
                        : Container(
                            margin: const EdgeInsets.all(Styles.marginS),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: Styles.marginS,
                                    top: 2,
                                  ),
                                  height: 24,
                                  width: double.infinity,
                                  color: boxColor,
                                  child: Text(
                                    text1?.toUpperCase() ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.apply(
                                          color: textColors[index % 3],
                                        ),
                                  ),
                                ),
                                Box.h8,
                                Text(text2.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                  );
                }),
              ),
              FilledButton(
                onPressed: () =>
                    _handleContinue(l10n.mixAndMatchScreenButtonContinue),
                child: Text(l10n.mixAndMatchScreenButtonContinue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container leftGridItem(
    Color boxColor,
    int index,
    BuildContext context,
    String? text1,
    List<Color> textColors,
  ) {
    final item = selectedBoxes[index];
    final itemImageData = item.imageData;
    logger.d('Image data is $itemImageData');
    if (itemImageData != null && itemImageData.isNotEmpty) {
      logger.d('Image data is not null');
      return Container(
        margin: const EdgeInsets.all(Styles.marginS),
        // alignment: Alignment.center,
        child: Image.memory(
          item.imageData!,
          width: double.infinity,
          // height: height,
          fit: BoxFit.fill,
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.all(Styles.marginS),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(Styles.radiusM),
        border: selectedBoxes.contains(index)
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: Styles.borderL,
              )
            : null,
      ),
      child: Center(
        child: Text(
          text1?.toUpperCase() ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.apply(
                color: textColors[index % 3],
              ),
        ),
      ),
    );
  }

  void _handleContinue(String snackBarContent) {
    if (selectedBoxes.isEmpty) {
      showSnackBar(context, snackBarContent);
    } else {
      AppNavigator.push<void>(AppRoute.mixAndMatchResult);
    }
  }

  /// Duplicate items in the list to create a grid of boxes
  void _generateBoxes() {
    selectedBoxes = cubit.state.expand((item) => [item, item]).toList();
  }
}
