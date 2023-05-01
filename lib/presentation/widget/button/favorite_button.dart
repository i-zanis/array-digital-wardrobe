import 'package:Array_App/domain/entity/item/item.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.item,
    required this.onFavoriteToggle,
    this.color,
  });

  final Item item;
  final void Function(Item item) onFavoriteToggle;
  final Color? color;

  @override
  State createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.item.isFavorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final updatedItem = widget.item.copyWith(isFavorite: !_isFavorite);
        widget.onFavoriteToggle(updatedItem);
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      child: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: widget.color ?? Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
