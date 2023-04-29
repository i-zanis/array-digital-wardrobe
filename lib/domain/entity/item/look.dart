import 'dart:typed_data';

import 'package:Array_App/domain/entity/base_entity.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/domain/entity/item/u_int_8_list_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'look.g.dart';

@JsonSerializable()
class Look extends BaseEntity {
  Look({
    super.id,
    this.items,
    // this.tags,
    this.name,
    this.description,
    this.lookImageData,
    this.lookWithUserImageData,
    this.userId,
  });

  Look.empty() : super.empty();

  factory Look.fromJson(Map<String, dynamic> json) => _$LookFromJson(json);

  Map<String, dynamic> toJson() => _$LookToJson(this);

  @override
  String toString() {
    return 'Look {id: $id, items: $items,'
        // ' tags: $tags,'
        ' name: $name, des: $description},'
        ' imageData: ${lookImageData != null ? 'Present' : 'Not present'
            ' lookWithUserImageData: '
            '${lookWithUserImageData != null ? 'Present' : 'Not present'}'}';
  }

  String? name;
  List<Item>? items = [];
  // List<Tag>? tags = [];
  String? description;
  @Uint8ListConverter()
  Uint8List? lookImageData;
  @Uint8ListConverter()
  Uint8List? lookWithUserImageData;
  int? userId;

  Look copyWith({
    String? name,
    List<Item>? items,
    // List<Tag>? tags,
    String? description,
    Uint8List? lookImageData,
    Uint8List? lookWithUserImageData,
  }) {
    return Look(
      id: id ?? super.id,
      items: items ?? this.items,
      // tags: tags ?? this.tags,
      name: name ?? this.name,
      description: description ?? this.description,
      lookImageData: lookImageData ?? this.lookImageData,
      lookWithUserImageData:
          lookWithUserImageData ?? this.lookWithUserImageData,
      userId: userId,
    );
  }
}
