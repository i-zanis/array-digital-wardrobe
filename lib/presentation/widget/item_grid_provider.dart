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
  });

  final List<Item> items;
  final double height;
  final bool isLooks;

  @override
  Widget build(BuildContext context) {
    final imageHeight = height * 0.5;
    final filteredItems = items;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: Styles.defaultPadding,
          mainAxisSpacing: Styles.defaultPadding,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1 / 1.7,
          children: List.generate(
            filteredItems.length,
            (index) {
              final item = filteredItems[index];
              return InteractiveGridItem(
                item: item,
                height: imageHeight,
                isTappable: true,
              );
            },
          ),
        )
      ],
    );
  }
}
