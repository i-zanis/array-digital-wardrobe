import 'package:Array_App/config/custom_color.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/domain/entity/item/category.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';

class SelectableBox extends StatelessWidget {
  const SelectableBox({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getBackgroundColor(context);
    final textColor = _getTextColor(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(Styles.marginS),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Styles.radiusM),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: Styles.borderL,
                )
              : null,
        ),
        child: Center(
          child: Text(
            getCategoryName(context, category),
            style: Theme.of(context).textTheme.bodyLarge?.apply(
                  color: textColor,
                ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    final index = category.index;
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColorMap = {
      0: colorScheme.primaryContainer,
      1: Theme.of(context).extension<CustomColors>()!.extended1Container!,
      2: colorScheme.tertiaryContainer,
    };
    return backgroundColorMap[index % 3] ?? getItemBackgroundColor(context);
  }

  Color _getTextColor(BuildContext context) {
    final index = category.index;
    final colorScheme = Theme.of(context).colorScheme;
    final color = {
      0: colorScheme.onPrimaryContainer,
      1: Theme.of(context).extension<CustomColors>()!.onExtended1Container!,
      2: colorScheme.onTertiaryContainer,
    };
    return color[index % 3] ?? Colors.black;
  }
}
