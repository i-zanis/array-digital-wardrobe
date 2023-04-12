import 'package:Array_App/core/route/route.dart';
import 'package:Array_App/presentation/screen/home/home_screen.dart';
import 'package:Array_App/presentation/screen/item_profile/item_profile_screen.dart';
import 'package:Array_App/presentation/screen/look_book/look_book_screen.dart';
import 'package:Array_App/presentation/screen/mix_and_match/category_items_screen.dart';
import 'package:Array_App/presentation/screen/root/root_screen.dart';
import 'package:flutter/widgets.dart';

import '../../presentation/screen/item_profile/camera_screen.dart';
import '../../presentation/screen/mix_and_match/mix_and_match_screen_result.dart';
import '../../presentation/screen/mix_and_match/select_item_in_grid_screen.dart';
import '../../presentation/screen/wardrobe/wardrobe_screen.dart';

// Class name (AppNavigator) due to conflict with Navigator
//
class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route<void> onGenerateRoute(RouteSettings routeSettings) {
    final route = routeSettings.name;
    switch (route) {
      case RoutePaths.home:
        return FadeRoute(screen: const HomeScreen());
      case RoutePaths.lookBook:
        return FadeRoute(screen: const LookBookScreen());
      case RoutePaths.wardrobe:
        return FadeRoute(screen: const WardrobeScreen());
      case RoutePaths.camera:
        return FadeRoute(screen: const CameraScreen());
      case RoutePaths.itemProfile:
        return FadeRoute(screen: const ItemProfileScreen());
      case RoutePaths.selectItemInGrid:
        return FadeRoute(
          screen: SelectItemInGridScreen(
            isFromCameraScreen: routeSettings.arguments,
          ),
        );
      case RoutePaths.mixAndMatchResult:
        return FadeRoute(
          screen: const MixAndMatchResultScreen(),
        );
      case RoutePaths.mixAndMatchCategoryItems:
        return FadeRoute(screen: const MixAndMatchCategoryItemsScreen());
      case RoutePaths.root:
        return FadeRoute(
          screen: RootScreen(initialScreenIndex: routeSettings.arguments ?? 0),
        );
      default:
        return FadeRoute(screen: const RootScreen());
    }
  }

  /// Pushes a new [route] onto the navigation stack with optional [arguments]
  /// of type [T].
  /// The type parameter [T] is the type of the [arguments] passed to the route.
  /// Returns a [Future] that completes when the pushed route is popped.
  static Future<void>? push<T>(AppRoute route, {T? arguments}) {
    return state?.pushNamed(RoutePaths.of(route), arguments: arguments);
  }

  /// Replaces the current route with a new [route] and optional [arguments]
  /// of type [T].
  /// The type parameter [T] is the type of the [arguments] passed to the route.
  /// Returns a [Future] that completes when the pushed route is popped.
  static Future<void>? replaceWith<T>(AppRoute route, [T? arguments]) {
    return state?.pushReplacementNamed(RoutePaths.of(route),
        arguments: arguments);
  }

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
