import 'package:Array_App/config/array_theme.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ArrayApp extends StatelessWidget {
  const ArrayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ArrayTheme.light,
      darkTheme: ArrayTheme.dark,
      title: 'Array Digital Wardrobe Application',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
    );
  }
}
