import 'package:Array_App/core/route/app_route.dart';

class RoutePaths {
  static const String root = '/';
  static const String home = '/home';
  static const String lookBook = '/look-book';
  static const String wardrobe = '/wardrobe';
  static const String camera = '/camera';
  static const String itemProfile = '/item-profile';
  static const String mixAndMatchPick = '/mix-and-match';
  static const String mixAndMatchResult = '/mix-and-match-result';
  static const Map<AppRoute, String> _pathMap = {
    AppRoute.root: root,
    AppRoute.home: home,
    AppRoute.lookBook: lookBook,
    AppRoute.wardrobe: wardrobe,
    AppRoute.itemProfile: itemProfile,
    AppRoute.camera: camera,
    AppRoute.mixAndMatchPick: mixAndMatchPick,
    AppRoute.mixAndMatchResult: mixAndMatchResult,
  };

  static String of(AppRoute route) => _pathMap[route] ?? home;
}
