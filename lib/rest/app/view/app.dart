import 'package:flutter/material.dart';
import 'package:wardrobe_frontend/l10n/l10n.dart';

class ArrayApp extends StatelessWidget {
  const ArrayApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return MaterialApp(
      title: 'Array',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Text('Hello World!')
    );
  }
}
