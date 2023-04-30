import 'package:Array_App/bloc/bloc.dart';
import 'package:Array_App/bloc/item/mix_and_match_cubit.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteractiveGridItem extends StatefulWidget {
  const InteractiveGridItem({
    super.key,
    required this.item,
    this.width,
    this.height,
    this.isTappable = false,
    this.isSelectionMode = false,
  });

  final Item item;
  final double? width;
  final double? height;
  final bool isTappable;
  final bool isSelectionMode;

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
    final textStyleTop = Theme.of(context).textTheme.bodySmall?.apply(
          color: titleColor,
        );
    final textStyleBottom = Theme.of(context).textTheme.titleSmall?.apply(
          color: subtitleColor,
        );
    final item = widget.item;
    final labelName = getStringOrDefault(item.name);
    final labelBrand = getStringOrDefault(item.brand);

    void tappableFunction() {
      if (widget.isSelectionMode) {
        return _handleFromMixAndMatch(context, item);
      }
      BlocProvider.of<ItemBloc>(context).add(
        UpdateItemToAdd(item),
      );
      AppNavigator.push<void>(AppRoute.itemProfile);
    }

    final container = Container(
      width: finalWidth,
      height: height,
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.imageData != null)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  color: getItemBackgroundColor(context),
                  alignment: Alignment.center,
                  child: Image.memory(
                    item.imageData!,
                    width: finalWidth,
                    height: height,
                    fit: BoxFit.fill,
                  ),
                ),
                _favouriteButton(context, item)
              ],
            )
          else
            Container(
              width: finalWidth,
              height: height,
              color: getItemBackgroundColor(context),
              child: const FallBackItemImage(),
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

  Padding _favouriteButton(BuildContext context, Item item) {
    return Padding(
      padding: const EdgeInsets.all(Styles.paddingS),
      child: FavoriteButton(
        item: item,
        onFavoriteToggle: (item) {
          BlocProvider.of<ItemBloc>(context).add(
            UpdateItemToAdd(item),
          );
          // TODO(jtl): to remove userid when user implemented
          final modifiedItem = item.copyWith(userId: item.userId ?? 1);
          context.read<ItemBloc>().add(
                UpdateItem(modifiedItem),
              );
        },
      ),
    );
  }

  void _handleFromMixAndMatch(BuildContext context, Item item) {
    context.read<MixAndMatchCubit>().replaceItemAndNavigate(
          item,
          () => AppNavigator.replaceWith<void>(AppRoute.mixAndMatchResult),
        );
  }
}
