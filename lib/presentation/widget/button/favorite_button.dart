import 'package:flutter/material.dart';

import '../../../domain/entity/item/item.dart';
import '../../../main_development.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.item,
    required this.onFavoriteToggle,
  });

  final Item item;
  final void Function(Item item) onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    // logger.d('Before FavButton.build ${item.isFavorite}');
    final isFavorite = item.isFavorite ?? false;
    // logger.d('After FavButton.build $isFavorite');
    return InkWell(
      onTap: () {
        final updatedItem = item.copyWith(isFavorite: !isFavorite);
        onFavoriteToggle(updatedItem);
        logger.d('After FavButton.onTap ${updatedItem.isFavorite}');
      },
      child: _getFavoriteIcon(context, isFavorite),
    );
  }

  Widget _getFavoriteIcon(BuildContext context, bool isFavorite) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
