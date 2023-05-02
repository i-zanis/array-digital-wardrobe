import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../domain/entity/item/item.dart';
import '../../widget/button/plus_button.dart';
import '../../widget/custom_chip.dart'; // Import your CustomChip widget

class TagSection extends StatelessWidget {
  const TagSection({super.key});

  @override
  Widget build(BuildContext context) {
    final labelTextStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ) ??
        const TextStyle();
    final itemToAdd = context.read<ItemBloc>().state.itemToAdd ?? Item.empty();
    final hasTags = itemToAdd.tags != null && itemToAdd.tags!.isNotEmpty;
    final tagChips = <Widget>[];
    if (hasTags) {
      for (final tag in itemToAdd.tags!) {
        tagChips.add(CustomChip(content: tag.name!.toUpperCase()));
      }
    }
    tagChips.add(PlusButton(
      heroTag: 'addTag',
      onPressed: () => {},
    ));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 8, // Adjust spacing between chips as needed
        runSpacing: 4, // Adjust run spacing between rows as needed
        children: tagChips,
      ),
    );
  }
}
