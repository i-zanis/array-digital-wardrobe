import 'package:Array_App/core/route/app_route.dart';

/// This class contains all the routes of the app.
/// It is used to generate the routes in AppNavigator.
class RoutePaths {
  static const String root = '/';
  static const String home = '/home';
  static const String lookBook = '/look-book';
  static const String wardrobe = '/wardrobe';
  static const String camera = '/camera';
  static const String itemProfile = '/item-profile';
  static const String selectItemInGrid = '/mix-and-match';
  static const String mixAndMatchResult = '/mix-and-match/result';
  static const String mixAndMatchCategoryItems =
      '/mix-and-match/result/category-items';
  static const String lookStudio =
      '/look-book/mix-and-match/result/look-studio';
  static const String lookProfile = '/look-book/profile';

  static const Map<AppRoute, String> _pathMap = {
    AppRoute.root: root,
    AppRoute.home: home,
    AppRoute.lookBook: lookBook,
    AppRoute.wardrobe: wardrobe,
    AppRoute.itemProfile: itemProfile,
    AppRoute.camera: camera,
    AppRoute.selectItemInGrid: selectItemInGrid,
    AppRoute.mixAndMatchResult: mixAndMatchResult,
    AppRoute.mixAndMatchCategoryItems: mixAndMatchCategoryItems,
    AppRoute.lookProfile: lookProfile,
    AppRoute.lookStudio: lookStudio,
  };

  /// Returns the route path for the given [AppRoute].
  static String of(AppRoute route) => _pathMap[route] ?? root;
}
