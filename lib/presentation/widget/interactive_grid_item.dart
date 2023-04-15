import 'package:Array_App/bloc/item/mix_and_match_cubit.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:Array_App/rest/util/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/item/item_bloc.dart';
import '../../config/style_config.dart';

class InteractiveGridItem extends StatefulWidget {
  const InteractiveGridItem({
    super.key,
    required this.item,
    this.width,
    this.height,
    this.isTappable = false,
  });

  final Item item;
  final double? width;
  final double? height;
  final bool isTappable;

  @override
  State createState() => _InteractiveGridItemState();
}

class _InteractiveGridItemState extends State<InteractiveGridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final finalWidth = widget.width ?? double.infinity;
    final height = MediaQuery.of(context).size.height * 0.25;
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = Theme.of(context).colorScheme.onSurface;
    final textStyleTop = Theme.of(context).textTheme.bodyLarge?.apply(
          color: titleColor,
        );
    final textStyleBottom = Theme.of(context).textTheme.titleMedium?.apply(
          color: subtitleColor,
        );
    final item = widget.item;
    final labelName = item.name.defaultIfEmpty();
    final labelBrand = item.brand.defaultIfEmpty();

    void tappableFunction() {
      if (item.id != null) {
        BlocProvider.of<ItemBloc>(context).add(
          UpdateItemToAdd(item),
        );
        AppNavigator.push<void>(AppRoute.itemProfile);
      } else {
        context.read<MixAndMatchCubit>().replaceItemAndNavigate(
              item,
              () => AppNavigator.push<void>(AppRoute.mixAndMatchResult),
            );
      }
    }

    final container = Container(
      width: finalWidth,
      height: height,
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : Colors.transparent,
      child: Column(
        children: [
          if (item.imageData != null)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.memory(
                    item.imageData!,
                    width: finalWidth,
                    height: height,
                    fit: BoxFit.fill,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(Styles.marginS),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.favorite),
                  ),
                ),
              ],
            )
          else
            Container(
              width: finalWidth,
              height: height,
              color: Colors.grey,
            ),
          Box.h8,
          Text(labelBrand, style: textStyleTop),
          Text(labelName, style: textStyleBottom)
        ],
      ),
    );

    if (widget.isTappable) {
      return InkWell(
        onTap: tappableFunction,
        child: container,
      );
    } else {
      return container;
    }
  }
}
