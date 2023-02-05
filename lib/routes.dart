import 'package:flutter/material.dart';
import 'package:wardrobe_frontend/core/fade_page_route.dart';
import 'package:wardrobe_frontend/ui/screens/home/home_screen.dart';
import 'package:wardrobe_frontend/ui/screens/splash_screen.dart';

class AppNavigator {
  // GlobalKey navigatorKey is a unique identifier that identifies
  // identify widgets in the widget tree, and NavigatorState is a type
  // that represents the current state of a Navigator widget.
  // By declaring this GlobalKey, it allows the widget tree to access the
  // NavigatorState and control the navigation of the app.
  // The static keyword makes this GlobalKey a singleton that is accessible
  // from anywhere in the app without having to pass it down the widget tree.
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case _Paths.splash:
        return FadeRoute(screen: SplashScreen());

      // case _Paths.lookBook:
      //   return FadeRoute(page: Screen());

      case _Paths.home:
      default:
        return FadeRoute(screen: HomeScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}

enum Routes { splash, home, lookBook, wardrobe, add, items }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String lookBook = '/look-book';
  static const String wardrobe = '/wardrobe';
  static const String addItem = '/add-item';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.lookBook: _Paths.lookBook,
    Routes.wardrobe: _Paths.wardrobe,
    Routes.add: _Paths.addItem
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}
