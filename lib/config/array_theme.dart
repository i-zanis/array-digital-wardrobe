import 'package:Array_App/config/color_scheme.dart';
import 'package:Array_App/config/custom_color.dart';
import 'package:flutter/material.dart';

class ArrayTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: CScheme.light2,
      brightness: Brightness.light,
      extensions: [lightCustomColors],
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: CScheme.dark2,
      brightness: Brightness.dark,
      extensions: [darkCustomColors],
    );
  }
}
