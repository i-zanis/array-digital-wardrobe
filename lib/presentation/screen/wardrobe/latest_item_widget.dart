import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:flutter/material.dart';

class LatestLookWidget extends StatelessWidget {
  const LatestLookWidget({
    super.key,
    required this.items,
  });

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = Theme.of(context).colorScheme.onSurface;
    final textStyleTop = Theme.of(context).textTheme.bodyLarge?.apply(
          color: titleColor,
        );
    final textStyleBottom = Theme.of(context).textTheme.titleMedium?.apply(
          color: subtitleColor,
        );

    if (items.isEmpty) {
      return const Center(child: Text('No items found'));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1 / 2,
          children: List.generate(
            items.length,
            (index) {
              var brand = items[index].brand ?? '';
              if (brand.isEmpty) brand = 'No brand';
              var name = items[index].name ?? '';
              if (name.isEmpty) name = 'No name';
              return Column(
                children: [
                  if (items[index].imageData != null)
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image(
                            image: MemoryImage(
                              items[index].imageData!,
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 120,
                          height: 380,
                          child: Icon(Icons.favorite),
                        ),
                      ],
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: height * 0.25,
                      color: Colors.grey,
                    ),
                  Box.h8,
                  Text(brand, style: textStyleTop),
                  Text(
                    name,
                    style: textStyleBottom,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
