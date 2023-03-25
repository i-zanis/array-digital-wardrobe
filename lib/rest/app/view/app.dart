import 'package:Array_App/config/theme.dart';
import 'package:flutter/material.dart';

import '../../../core/route/app_navigator.dart';
import '../../../l10n/l10n.dart';

class ArrayApp extends StatelessWidget {
  const ArrayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ArrayTheme.light,
      darkTheme: ArrayTheme.dark,
      color: Colors.white,
      title: 'Array Digital Wardrobe Application',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
    );
  }
}
