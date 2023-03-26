import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

class Uint8ListConverter implements JsonConverter<Uint8List?, List?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List? json) =>
      json != null ? Uint8List.fromList(json.cast<int>()) : null;

  @override
  List? toJson(Uint8List? object) => object?.toList();
}
