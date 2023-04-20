import 'package:flutter/material.dart';

/// A [PageRoute] that transitions the new screen in with a fade animation.
/// The new screen is faded in over the current screen with [FadeTransition].
/// The [screen] is the new screen to be displayed.
/// The [settings] is the route settings for this route.
class FadeRoute<T> extends PageRouteBuilder<T> {
  FadeRoute({required this.screen})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              screen,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget screen;
}
