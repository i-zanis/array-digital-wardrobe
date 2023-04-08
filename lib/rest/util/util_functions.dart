import 'dart:async';
import 'dart:ui' as ui;

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

// Future<ui.Image> uint8ListToImage(Uint8List? byteData) async {
//   if (byteData == null) {
//     return Future.value();
//   }
//   final codec = await ui.instantiateImageCodec(byteData);
//   final frameInfo = await codec.getNextFrame();
//   return frameInfo.image;
// }

Future<ui.Image> uint8ListToImage(Uint8List? img) async {
  if (img == null) {
    return Future.value();
  }
  final Completer<ui.Image> completer = Completer();

  ui.decodeImageFromList(img, (ui.Image img) {
    return completer.complete(img);
  });

  return completer.future;
}

Future<Uint8List> imageAssetToUint8List({
  required String source,
  required int width,
  required int height,
}) async {
  final ByteData data = await rootBundle.load(source);

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
      content: Text(content,
          style: Theme.of(context).textTheme.bodyMedium?.apply(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              )),
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
