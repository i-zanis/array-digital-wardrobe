import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context)
        .textTheme
        .labelLarge
        ?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer);
    return Chip(
      label: Text(content),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      labelStyle: labelStyle,
      side: BorderSide(
          // color: Theme.of(context).colorScheme.secondary,
          color: Colors.transparent),
    );
  }
}
