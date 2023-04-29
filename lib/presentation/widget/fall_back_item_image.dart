import 'package:flutter/material.dart';

class FallBackItemImage extends StatelessWidget {
  const FallBackItemImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.checkroom_rounded,
      size: 100,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }
}
