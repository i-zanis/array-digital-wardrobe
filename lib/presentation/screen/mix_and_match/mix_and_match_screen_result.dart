import 'package:Array_App/bloc/item/mix_and_match_cubit.dart';
import 'package:Array_App/config/custom_color.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/l10n/l10n.dart';
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
      Theme.of(context).extension<CustomColors>()!.extended1Container!,
      Theme.of(context).colorScheme.tertiaryContainer
    ];
    final textColors = <Color>[
      Theme.of(context).colorScheme.onPrimaryContainer,
      Theme.of(context).extension<CustomColors>()!.onExtended1Container!,
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
                  final text1 =
                      getCategoryName(context, selectedBoxes[index].category);
                  final text2 = l10n.mixAndMatchAddFromWardrobe;
                  return GestureDetector(
                    onTap: () {
                      _handleAddFromWardrobe(index);
                    },
                    child: index.isEven
                        ? leftGridItem(
                            boxColor,
                            index,
                            context,
                            text1,
                            textColors,
                          )
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
              CustomFilledButton(
                onPressed: () =>
                    _handleContinue(l10n.mixAndMatchResultScreenConfirmError),
                content: l10n.mixAndMatchConfirm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAddFromWardrobe(int index) {
    if (index.isOdd) {
      cubit.selectItem(selectedBoxes[index]);
      AppNavigator.replaceWith<void>(
        AppRoute.mixAndMatchCategoryItems,
      );
    }
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
    if (itemImageData != null && itemImageData.isNotEmpty) {
      return Container(
        color: getItemBackgroundColor(context),
        margin: const EdgeInsets.all(Styles.marginS),
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
    if (selectedBoxes.isEmpty | selectedBoxes.any((item) => item.id == null)) {
      showSnackBar(context, snackBarContent);
    } else {
      AppNavigator.push<void>(AppRoute.lookStudio);
    }
  }

  /// Duplicate items in the list to create a grid of boxes
  void _generateBoxes() {
    selectedBoxes = cubit.state.items.expand((item) => [item, item]).toList();
  }
}
