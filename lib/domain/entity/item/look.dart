import 'dart:typed_data';

import 'package:Array_App/domain/entity/base_entity.dart';
import 'package:Array_App/domain/entity/item/u_int_8_list_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item.dart';

part 'look.g.dart';

@JsonSerializable()
class Look extends BaseEntity {
  Look({
    super.id,
    this.items,
    this.name,
    this.description,
    this.lookImageData,
    this.lookWithUserImageData,
  });

  Look.empty() : super.empty();

  factory Look.fromJson(Map<String, dynamic> json) => _$LookFromJson(json);

  Map<String, dynamic> toJson() => _$LookToJson(this);

  @override
  String toString() {
    return 'Look {id: $id, items: $items,'
        ' name: $name, des: $description},'
        ' imageData: ${lookImageData != null ? 'Present' : 'Not present'
            ' lookWithUserImageData: '
            '${lookWithUserImageData != null ? 'Present' : 'Not present'}'}';
  }

  String? name;
  List<Item>? items = [];
  String? description;
  @Uint8ListConverter()
  Uint8List? lookImageData;
  @Uint8ListConverter()
  Uint8List? lookWithUserImageData;

  Look copyWith({
    String? name,
    List<Item>? items,
    String? description,
    Uint8List? lookImageData,
    Uint8List? lookWithUserImageData,
  }) {
    return Look(
      id: id ?? super.id,
      items: items ?? this.items,
      name: name ?? this.name,
      description: description ?? this.description,
      lookImageData: lookImageData ?? this.lookImageData,
      lookWithUserImageData:
          lookWithUserImageData ?? this.lookWithUserImageData,
    );
  }
}
