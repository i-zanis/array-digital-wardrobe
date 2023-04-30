import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:flutter/material.dart';

class MixAndMatchCategoryItemsScreen extends StatelessWidget {
  const MixAndMatchCategoryItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.mixAndMatchScreenTitle,
        subtitle: l10n.mixAndMatchAddFromWardrobe,
        showLeading: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Styles.defaultMargin),
          child: ItemGridView(isSelectionMode: true),
        ),
      ),
    );
  }
}
