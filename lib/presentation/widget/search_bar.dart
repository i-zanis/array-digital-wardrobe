import 'package:flutter/material.dart';

import '../../config/style_config.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.searchCubit,
    required this.hintText,
  });

  final dynamic searchCubit;
  final String hintText;

  // TODO(jtl): Add voice input

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: MaterialStateProperty.all(1),
      leading: const Padding(
        padding: EdgeInsets.all(Styles.paddingS),
        child: Icon(Icons.search),
      ),
      // elevation: MaterialStateProperty.all(2),
      hintText: hintText,
      onChanged: (value) => searchCubit.filterItems(context, value),
    );
  }
}
