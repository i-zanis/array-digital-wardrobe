import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/presentation/widget/interactive_grid_look.dart';
import 'package:flutter/cupertino.dart';

class LookGridProvider extends StatelessWidget {
  const LookGridProvider({
    super.key,
    this.height = 380,
    this.isLooks = false,
    required this.looks,
  });

  final List<Look> looks;
  final double height;
  final bool isLooks;

  @override
  Widget build(BuildContext context) {
    final imageHeight = height * 0.5;
    final filteredLooks = looks;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: Styles.paddingS,
          mainAxisSpacing: Styles.defaultPadding,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.68888,
          children: List.generate(
            filteredLooks.length,
            (index) {
              final look = filteredLooks[index];
              return InteractiveGridLook(
                look: look,
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
