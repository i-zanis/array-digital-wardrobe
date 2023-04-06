import 'package:Array_App/config/style_config.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/item/category.dart';

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
        margin: const EdgeInsets.all(StyleConfig.marginS),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(StyleConfig.radiusM),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: StyleConfig.borderL,
                )
              : null,
        ),
        child: Center(
          child: Text(
            category.name.toUpperCase(),
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
    switch (index % 3) {
      case 0:
        return Theme.of(context).colorScheme.primaryContainer;
      case 1:
        return Theme.of(context).colorScheme.secondaryContainer;
      case 2:
        return Theme.of(context).colorScheme.tertiaryContainer;
      default:
        return Colors.grey;
    }
  }

  Color _getTextColor(BuildContext context) {
    final index = category.index;
    switch (index % 3) {
      case 0:
        return Theme.of(context).colorScheme.onPrimaryContainer;
      case 1:
        return Theme.of(context).colorScheme.onSecondaryContainer;
      case 2:
        return Theme.of(context).colorScheme.onTertiaryContainer;
      default:
        return Colors.black;
    }
  }
}
