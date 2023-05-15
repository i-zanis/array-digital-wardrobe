import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/route/app_navigator.dart';
import '../../core/route/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const double _splashIconSize = 50;

  @override
  void initState() {
    scheduleMicrotask(() async {
      // await AppImages.precacheAssets(context);
      await Future.delayed(const Duration(milliseconds: 400));
      await AppNavigator.replaceWith<void>(AppRoute.root);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
