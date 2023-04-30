import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/presentation/widget/interactive_grid_item.dart';
import 'package:flutter/cupertino.dart';

class ItemGridProvider extends StatelessWidget {
  const ItemGridProvider({
    super.key,
    this.height = 380,
    this.isLooks = false,
    required this.items,
    this.isSelectionMode = false,
  });

  final List<Item> items;
  final double height;
  final bool isLooks;
  final bool isSelectionMode;

  @override
  Widget build(BuildContext context) {
    final imageHeight = height * 0.5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: Styles.paddingS,
          mainAxisSpacing: Styles.defaultPadding,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // width == 0.7 * height
          childAspectRatio: 0.7,
          children: List.generate(
            items.length,
            (index) {
              final item = items[index];
              return InteractiveGridItem(
                item: item,
                height: imageHeight,
                isTappable: true,
                isSelectionMode: isSelectionMode,
              );
            },
          ),
        )
      ],
    );
  }
}
