import 'package:Array_App/ui/screens/home/home_screen.dart';
import 'package:Array_App/ui/screens/item_profile/image_upload_screen.dart';
import 'package:Array_App/ui/screens/item_profile/item_profile_screen.dart';
import 'package:Array_App/ui/screens/look_book/look_book_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentScreenIndex = index;
          });
        },
        selectedIndex: currentScreenIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Commute',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
        ],
      ),
      body: [
        const HomeScreen(),
        const LookBookScreen(),
        const CameraScreen(),
        const ItemProfileScreen()
      ][currentScreenIndex],
    );
  }
}
