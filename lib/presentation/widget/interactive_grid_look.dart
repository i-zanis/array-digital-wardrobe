import 'package:Array_App/bloc/bloc.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteractiveGridLook extends StatefulWidget {
  const InteractiveGridLook({
    super.key,
    required this.look,
    this.width,
    this.height,
    this.isTappable = false,
  });

  final Look look;
  final double? width;
  final double? height;
  final bool isTappable;

  @override
  State createState() => _InteractiveGridLookState();
}

class _InteractiveGridLookState extends State<InteractiveGridLook> {
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
    final textStyleBottom = Theme.of(context).textTheme.titleMedium?.apply(
          color: subtitleColor,
        );
    final look = widget.look;
    final labelBrand = getStringOrDefault(look.description);
    final labelName = getStringOrDefault(look.name);

    void tappableFunction() {
      if (look.id != null) {
        BlocProvider.of<ItemBloc>(context).add(
          UpdateLookToAdd(look),
        );
        AppNavigator.push<void>(AppRoute.lookProfile);
        // }
        // else {
        //   context.read<MixAndMatchCubit>().replaceLookAndNavigate(
        //         item,
        //         () => AppNavigator.push<void>(AppRoute.mixAndMatchResult),
        //       );
        // }
      }
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
          if (look.lookImageData != null)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  color: getItemBackgroundColor(context),
                  alignment: Alignment.center,
                  child: Image.memory(
                    look.lookImageData!,
                    width: finalWidth,
                    height: height,
                    // fit: BoxFit.fill,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(Styles.paddingS),
                //   child: FavoriteButton(
                //     item: Item.empty(),
                //     onFavoriteToggle: (updatedItem) {
                //       BlocProvider.of<ItemBloc>(context).add(
                //         UpdateItemToAdd(updatedItem),
                //       );
                //     },
                //   ),
                // ),
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
          Text(
            labelBrand,
            style: textStyleTop,
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
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
