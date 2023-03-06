import 'package:flutter/material.dart';

import '../../../config/array_theme.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.dart';

class ArrayApp extends StatelessWidget {
  const ArrayApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return MaterialApp(
      theme: ArrayTheme.light,
      darkTheme: ArrayTheme.dark,
      color: Colors.white,
      title: 'Array Digital Wardrobe ArrayApp',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
    );
  }
}
