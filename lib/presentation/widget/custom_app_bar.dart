import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leading = const SizedBox.shrink(),
    this.showLeading = false,
    this.height = defaultHeight * 1.5,
    this.title = '',
    this.subtitle = '',
  });

  static const defaultHeight = 56.0;
  final String title;
  final String subtitle;
  final Widget? leading;
  final bool showLeading;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.primaryContainer,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: Colors.transparent,
      leading: _leadingActionButton(context),
      centerTitle: true,
      toolbarHeight: height,
      title: Column(
        children: [
          Box.h8,
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Box.h8,
        ],
      ),
    );
  }

  Widget? _leadingActionButton(BuildContext context) => showLeading
      ? const IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: AppNavigator.pop,
        )
      : leading;

  @override
  Size get preferredSize => Size.fromHeight(height);
}
