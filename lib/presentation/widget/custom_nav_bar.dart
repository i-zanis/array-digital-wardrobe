// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../core/route/app_navigator.dart';
// import '../../core/route/app_route.dart';
//
// class CustomNavBar extends StatefulWidget {
//   const CustomNavBar({super.key});
//
//   @override
//   State createState() => _CustomNavBarState();
// }
//
// class _CustomNavBarState extends State<CustomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return NavigationBar(
//       onDestinationSelected: (int index) {
//         if (isCameraButtonPressed(index)) return;
//         setState(() {
//           currentScreenIndex = index;
//         });
//       },
//       selectedIndex: currentScreenIndex,
//       destinations: const <Widget>[
//         NavigationDestination(
//           icon: Icon(Icons.explore),
//           label: 'Home',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.commute),
//           label: 'Look Book',
//         ),
//         NavigationDestination(
//           selectedIcon: Icon(Icons.bookmark),
//           icon: Icon(Icons.bookmark_border),
//           label: 'Wardrobe',
//         ),
//         NavigationDestination(
//           selectedIcon: Icon(Icons.bookmark),
//           icon: Icon(
//             Icons.bookmark_border,
//           ),
//           label: 'Add',
//         ),
//       ],
//     );
//   }
//
//   // Fallback because CameraScreen appears on top of everything in the stack
//   bool isCameraButtonPressed(int index) {
//     if (index == 3) {
//       AppNavigator.push<AppRoute>(AppRoute.camera);
//       return true;
//     }
//     return false;
//   }
// }
