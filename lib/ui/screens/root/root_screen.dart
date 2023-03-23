import 'package:Array_App/routes.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../item_profile/item_profile_screen.dart';
import '../look_book/look_book_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentScreenIndex = 0;
  final List<Widget> screens = const [
    HomeScreen(),
    ItemProfileScreen(),
    LookBookScreen(),
  ];

  // Fallback because CameraScreen appears on top of everything in the stack
  bool isCameraButtonPressed(int index) {
    if (index == 3) {
      AppNavigator.push<AppRoute>(AppRoute.camera);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentScreenIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (isCameraButtonPressed(index)) return;
          setState(() {
            currentScreenIndex = index;
          });
        },
        selectedIndex: currentScreenIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Look Book',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Wardrobe',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(
              Icons.bookmark_border,
            ),
            label: 'Add',
          ),
        ],
      ),
    );
  }
}
