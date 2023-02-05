import 'package:flutter/material.dart';

// Custom class to create specific type of route transition
// The new screen is faded in over the current screen with FadeTransition
class FadeRoute extends PageRouteBuilder {
  FadeRoute({required this.screen})
      : super(
          pageBuilder: (_, __, ___) => screen,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget screen;
}
