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
    final itemToAdd = context.read<ItemBloc>().state.itemToAdd ?? Item.empty();
    final hasTags = itemToAdd.tags != null && itemToAdd.tags!.isNotEmpty;
    final tagChips = <Widget>[];
    tagChips.add(const CustomChip(content: 'Tags: '));
    if (hasTags) {
      for (final tag in itemToAdd.tags!) {
        tagChips.add(CustomChip(content: tag.name!.toUpperCase()));
      }
    }
    tagChips.add(PlusButton(
      heroTag: 'addTag',
      onPressed: () => {},
    ));
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8, // Adjust spacing between chips as needed
      runSpacing: 4, // Adjust run spacing between rows as needed
      children: tagChips,
    );
  }
}
