import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const extended1 = Color(0xFF009FFF);
const extended2 = Color(0xFFFF69B4);

CustomColors lightCustomColors = const CustomColors(
  sourceExtended1: Color(0xFF009FFF),
  extended1: Color(0xFF0062A0),
  onExtended1: Color(0xFFFFFFFF),
  extended1Container: Color(0xFFD0E4FF),
  onExtended1Container: Color(0xFF001D35),
  sourceExtended2: Color(0xFFFF69B4),
  extended2: Color(0xFFAC2471),
  onExtended2: Color(0xFFFFFFFF),
  extended2Container: Color(0xFFFFD8E6),
  onExtended2Container: Color(0xFF3D0024),
);

CustomColors darkCustomColors = const CustomColors(
  sourceExtended1: Color(0xFF009FFF),
  extended1: Color(0xFF9BCAFF),
  onExtended1: Color(0xFF003256),
  extended1Container: Color(0xFF004A7A),
  onExtended1Container: Color(0xFFD0E4FF),
  sourceExtended2: Color(0xFFFF69B4),
  extended2: Color(0xFFFFB0D0),
  onExtended2: Color(0xFF63003D),
  extended2Container: Color(0xFF8C0058),
  onExtended2Container: Color(0xFFFFD8E6),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceExtended1,
    required this.extended1,
    required this.onExtended1,
    required this.extended1Container,
    required this.onExtended1Container,
    required this.sourceExtended2,
    required this.extended2,
    required this.onExtended2,
    required this.extended2Container,
    required this.onExtended2Container,
  });

  final Color? sourceExtended1;
  final Color? extended1;
  final Color? onExtended1;
  final Color? extended1Container;
  final Color? onExtended1Container;
  final Color? sourceExtended2;
  final Color? extended2;
  final Color? onExtended2;
  final Color? extended2Container;
  final Color? onExtended2Container;

  @override
  CustomColors copyWith({
    Color? sourceExtended1,
    Color? extended1,
    Color? onExtended1,
    Color? extended1Container,
    Color? onExtended1Container,
    Color? sourceExtended2,
    Color? extended2,
    Color? onExtended2,
    Color? extended2Container,
    Color? onExtended2Container,
  }) {
    return CustomColors(
      sourceExtended1: sourceExtended1 ?? this.sourceExtended1,
      extended1: extended1 ?? this.extended1,
      onExtended1: onExtended1 ?? this.onExtended1,
      extended1Container: extended1Container ?? this.extended1Container,
      onExtended1Container: onExtended1Container ?? this.onExtended1Container,
      sourceExtended2: sourceExtended2 ?? this.sourceExtended2,
      extended2: extended2 ?? this.extended2,
      onExtended2: onExtended2 ?? this.onExtended2,
      extended2Container: extended2Container ?? this.extended2Container,
      onExtended2Container: onExtended2Container ?? this.onExtended2Container,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceExtended1: Color.lerp(sourceExtended1, other.sourceExtended1, t),
      extended1: Color.lerp(extended1, other.extended1, t),
      onExtended1: Color.lerp(onExtended1, other.onExtended1, t),
      extended1Container:
          Color.lerp(extended1Container, other.extended1Container, t),
      onExtended1Container:
          Color.lerp(onExtended1Container, other.onExtended1Container, t),
      sourceExtended2: Color.lerp(sourceExtended2, other.sourceExtended2, t),
      extended2: Color.lerp(extended2, other.extended2, t),
      onExtended2: Color.lerp(onExtended2, other.onExtended2, t),
      extended2Container:
          Color.lerp(extended2Container, other.extended2Container, t),
      onExtended2Container:
          Color.lerp(onExtended2Container, other.onExtended2Container, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceExtended1]
  ///   * [CustomColors.extended1]
  ///   * [CustomColors.onExtended1]
  ///   * [CustomColors.extended1Container]
  ///   * [CustomColors.onExtended1Container]
  ///   * [CustomColors.sourceExtended2]
  ///   * [CustomColors.extended2]
  ///   * [CustomColors.onExtended2]
  ///   * [CustomColors.extended2Container]
  ///   * [CustomColors.onExtended2Container]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceExtended1: sourceExtended1!.harmonizeWith(dynamic.primary),
      extended1: extended1!.harmonizeWith(dynamic.primary),
      onExtended1: onExtended1!.harmonizeWith(dynamic.primary),
      extended1Container: extended1Container!.harmonizeWith(dynamic.primary),
      onExtended1Container:
          onExtended1Container!.harmonizeWith(dynamic.primary),
      sourceExtended2: sourceExtended2!.harmonizeWith(dynamic.primary),
      extended2: extended2!.harmonizeWith(dynamic.primary),
      onExtended2: onExtended2!.harmonizeWith(dynamic.primary),
      extended2Container: extended2Container!.harmonizeWith(dynamic.primary),
      onExtended2Container:
          onExtended2Container!.harmonizeWith(dynamic.primary),
    );
  }
}
