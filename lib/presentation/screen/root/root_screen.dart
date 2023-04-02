import 'package:Array_App/core/route/route.dart';
import 'package:Array_App/presentation/screen/home/home_screen.dart';
import 'package:Array_App/presentation/screen/item_profile/item_profile_screen.dart';
import 'package:Array_App/presentation/screen/look_book/look_book_screen.dart';
import 'package:Array_App/presentation/screen/wardrobe/wardrobe_screen.dart';
import 'package:Array_App/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../rest/util/number_functions.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, this.initialScreenIndex = 0});

  final Object? initialScreenIndex;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late int currentScreenIndex;
  final List<Widget> screens = const [
    HomeScreen(),
    LookBookScreen(),
    WardrobeScreen(),
    ItemProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentScreenIndex = parseToIntOrDefault(widget.initialScreenIndex);
  }

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
      appBar: CustomAppBar(
        height: 0,
      ),
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
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(Icons.book_outlined),
            label: 'Look Book',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.checkroom),
            icon: Icon(Icons.checkroom_outlined),
            label: 'Wardrobe',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add_a_photo),
            icon: Icon(
              Icons.add_a_photo_outlined,
            ),
            label: 'Add',
          ),
        ],
      ),
    );
  }
}
