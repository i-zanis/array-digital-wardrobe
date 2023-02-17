import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          AppNavigator.push(Routes.home);
          break;
        case 1:
          AppNavigator.push(Routes.lookBook);
          break;
        case 2:
          AppNavigator.push(Routes.wardrobe);
          break;
        case 3:
          AppNavigator.push(Routes.add);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      backgroundColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: l10.appBarHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.note_alt_rounded),
          label: l10.appBarLookBook,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.temple_buddhist_sharp),
          label: l10.appBarWardrobe,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.add),
          label: l10.appBarAdd,
        ),
      ],
      onTap: _onItemTapped,
    );
  }
}
