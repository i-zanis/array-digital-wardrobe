import 'package:Array_App/domain/entity/item/item.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton(
      {super.key,
      required this.item,
      required this.onFavoriteToggle,
      this.color});

  final Item item;
  final void Function(Item item) onFavoriteToggle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isFavorite = item.isFavorite ?? false;
    return InkWell(
      onTap: () {
        final updatedItem = item.copyWith(isFavorite: !isFavorite);
        onFavoriteToggle(updatedItem);
      },
      child: _getFavoriteIcon(context, isFavorite),
    );
  }

  Widget _getFavoriteIcon(BuildContext context, bool isFavorite) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: color ?? Theme.of(context).colorScheme.tertiary,
    );
  }
}
