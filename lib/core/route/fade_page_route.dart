import 'package:flutter/material.dart';

// Custom class to create a specific type of route transition
// The new screen is faded in over the current screen with FadeTransition
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
