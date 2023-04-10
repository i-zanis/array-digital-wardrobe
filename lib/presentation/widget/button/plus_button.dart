import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({
    super.key,
    required this.heroTag,
    required this.onPressed,
  });

  final String heroTag;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      elevation: 0,
      heroTag: heroTag,
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
