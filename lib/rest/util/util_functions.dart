import 'dart:async';
import 'dart:ui' as ui;

import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Returns True if the [lastFetched] is older than the [timeToLive].
bool isStale(DateTime lastFetched, Duration timeToLive) {
  return lastFetched.add(timeToLive).isBefore(DateTime.now());
}

/// Returns the [kelvin] temperature as a Celsius temperature.
double kelvinToCelsius(double kelvin) {
  return kelvin - 273.15;
}

/// Returns the [kelvin] temperature as a Fahrenheit temperature.
double kelvinToFahrenheit(double kelvin) {
  return kelvin * 9 / 5 - 459.67;
}

Future<Uint8List> imageToUint8list(String key) async {
  return (await rootBundle.load(key)).buffer.asUint8List();
}

Future<ui.Image> uInt8ListToImage(Uint8List? img) async {
  if (img == null) {
    return Future.value();
  }
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(img, completer.complete);
  return completer.future;
}

Future<Uint8List> imageAssetToUint8List({
  required String source,
  required int width,
  required int height,
}) async {
  final data = await rootBundle.load(source);

  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  final fi = await codec.getNextFrame();

  final uint8list = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();

  return uint8list;
}

// TODO(jtl): move it elsewhere
void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
      ),
      duration: const Duration(
        seconds: 2,
      ),
      //   action: SnackBarAction(
      //     label: 'Dismiss',
      //     onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      //   ),
    ),
  );
}

Color getItemBackgroundColor(BuildContext context) {
  return Theme.of(context).colorScheme.surfaceVariant.withOpacity(
        0.4,
      );
}

T getValueOrDefault<T>(dynamic value, T defaultValue) {
  if (value == null) return defaultValue;
  if (value is String) {
    if (value.isEmpty) return defaultValue;
    return value as T;
  }
  if (value is num) {
    if (value == 0) return defaultValue;
    return value as T;
  }

  return value as T;
}

String getStringOrDefault(dynamic value, [String defaultValue = '']) {
  if (value == null) return defaultValue;
  if (value is String) {
    if (value.isEmpty) return defaultValue;
    return value;
  }
  if (value is num) {
    return value.toString();
  }
  return value.toString();
}

String getCategoryName(BuildContext context, Enum? category) {
  final l10n = context.l10n;
  final categoryMap = {
    Category.TOP: l10n.categoryTop,
    Category.BOTTOM: l10n.categoryBottom,
    Category.SHOES: l10n.categoryShoes,
    Category.ACCESSORIES: l10n.categoryAccessories,
    Category.INNERWEAR: l10n.categoryInnerwear,
    Category.OTHER: l10n.categoryOther,
  };
  final name = categoryMap[category] ?? l10n.categoryOther;
  return name.toUpperCase();
}
