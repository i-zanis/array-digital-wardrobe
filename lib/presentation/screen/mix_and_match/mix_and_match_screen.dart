import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../config/style_config.dart';
import '../../widget/custom_app_bar.dart';

class MixAndMatchScreen extends StatefulWidget {
  const MixAndMatchScreen({super.key});

  @override
  State createState() => _MixAndMatchScreenState();
}

class _MixAndMatchScreenState extends State<MixAndMatchScreen> {
  List<int> selectedBoxes = [];

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
                        'Container ${index + 1}',
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
            FilledButton(onPressed: () => {}, child: Text('Continue')),
          ],
        ),
      ),
    );
  }

  void _matchStyle() {}
}

enum MixAndMatchType { top, bottom, shoes, accessories, innerwear, other }
