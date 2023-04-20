import 'package:Array_App/domain/entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/item/mix_and_match_cubit.dart';
import '../../../core/route/app_navigator.dart';
import '../../../core/route/app_route.dart';
import '../../../rest/util/util_functions.dart';

class LookBookComponent extends StatefulWidget {
  const LookBookComponent({
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
  State createState() => _LookBookComponentState();
}

class _LookBookComponentState extends State<LookBookComponent> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final finalWidth = widget.width ?? 120;
    final height = MediaQuery.of(context).size.height * 0.15;
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = Theme.of(context).colorScheme.onSurface;
    final textStyleTop = Theme.of(context).textTheme.bodyLarge?.apply(
          color: titleColor,
        );
    final textStyleBottom = Theme.of(context).textTheme.titleMedium?.apply(
          color: subtitleColor,
        );
    final item = widget.item;

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
                  height: 100,
                  width: 100,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  alignment: Alignment.center,
                  child: Image.memory(
                    item.imageData!,
                    width: finalWidth,
                    height: height,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.check,
                    color: Colors.white.withOpacity(0.5),
                    size: 100,
                  ),
                ),
              ],
            )
          else
            Container(
              width: finalWidth,
              height: height,
              color: Colors.grey,
              child: Center(
                child: Text(getStringOrDefault(item.name, 'No name')),
              ),
            ),
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
