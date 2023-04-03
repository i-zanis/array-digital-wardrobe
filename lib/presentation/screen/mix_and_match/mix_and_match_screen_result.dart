import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/main_development.dart';
import 'package:Array_App/presentation/widget/custom_app_bar.dart';
import 'package:Array_App/presentation/widget/sized_box/sized_box_x8.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';

class MixAndMatchResultScreen extends StatefulWidget {
  MixAndMatchResultScreen({super.key, required this.selectedBoxes}) {}

  final Object? selectedBoxes;

  @override
  State createState() => _MixAndMatchResultScreenState();
}

class _MixAndMatchResultScreenState extends State<MixAndMatchResultScreen> {
  List<Category> selectedBoxes = [];

  @override
  void initState() {
    selectedBoxes = List<Category>.from(
      (widget.selectedBoxes as List<dynamic>?)
              ?.expand((e) => [e as Category, e as Category])
              .toList() ??
          [],
    );
    logger.i(selectedBoxes.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final list = ModalRoute.of(context)?.settings.arguments;
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

    final boxText = <Category>[
      Category.TOP,
      Category.BOTTOM,
      Category.SHOES,
      Category.ACCESSORIES,
      Category.INNERWEAR,
      Category.OTHER,
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
          padding: const EdgeInsets.all(StyleConfig.defaultMargin),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(selectedBoxes.length, (index) {
                  final boxColor = backgroundColors[index % 3];
                  var text1 = selectedBoxes[index].name;
                  final text2 = l10n.mixAndMatchAddFromWardrobe;
                  return GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: index.isEven
                        ? Container(
                            margin: const EdgeInsets.all(StyleConfig.marginS),
                            decoration: BoxDecoration(
                              color: boxColor,
                              borderRadius:
                                  BorderRadius.circular(StyleConfig.radiusM),
                              border: selectedBoxes.contains(index)
                                  ? Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: StyleConfig.borderL,
                                    )
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                text1.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.apply(
                                      color: textColors[index % 3],
                                    ),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(StyleConfig.marginS),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: StyleConfig.marginS, top: 2),
                                  height: 24,
                                  width: double.infinity,
                                  color: boxColor,
                                  child: Text(
                                    text1.toString().toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.apply(
                                          color: textColors[index % 3],
                                        ),
                                  ),
                                ),
                                SizedBox8(),
                                Text(text2.toString().toUpperCase(),
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
                    _continue(l10n.mixAndMatchScreenButtonContinue),
                child: Text(l10n.mixAndMatchScreenButtonContinue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _continue(String snackBarContent) {
    if (selectedBoxes.isEmpty) {
      showSnackBar(context, snackBarContent);
    } else {
      AppNavigator.push<void>(AppRoute.mixAndMatchResult);
    }
  }
}
