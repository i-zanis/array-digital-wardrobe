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
        ?.copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer);
    return Chip(
      label: Text(content),
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      labelStyle: labelStyle,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      side: const BorderSide(
        // color: Theme.of(context).colorScheme.secondary,
        color: Colors.transparent,
      ),
    );
  }
}
