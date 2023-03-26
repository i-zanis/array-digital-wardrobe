import 'dart:typed_data';

import 'package:Array_App/domain/entity/base_entity.dart';
import 'package:Array_App/domain/entity/item/look.dart';
import 'package:Array_App/domain/entity/item/tag.dart';
import 'package:Array_App/domain/entity/item/u_int_8_list_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends BaseEntity {
  Item({
    super.id,
    this.createdAt,
    this.name,
    this.colors,
    this.brand,
    this.category,
    this.looks,
    this.isFavorite,
    this.price,
    this.userId,
    this.imageLocalPath,
    this.imageData,
    this.notes,
    this.size,
    this.tags,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item.empty() : super.empty();

  DateTime? createdAt;
  String? name;
  String? brand;
  String? size;
  List<String>? colors;
  List<Tag>? tags;
  String? category;
  List<Look>? looks;
  bool? isFavorite = false;
  double? price;
  int? userId;
  String? imageLocalPath;
  @Uint8ListConverter()
  Uint8List? imageData;
  String? notes;

// Map<String, dynamic> toJson() => <String, dynamic>{
//       'id': id,
//       'createdAt': createdAt?.toIso8601String(),
//       'name': name,
//       'brand': brand,
//       'size': size,
//       'colors': colors,
//       'tags': tags?.map((e) => e.toJson()).toList(),
//       'category': category,
//       'looks': looks,
//       'isFavorite': isFavorite,
//       'price': price,
//       'userId': userId,
//       'imageLocalPath': imageLocalPath,
//       // 'imageData': imageData != null ? List<int>.from(imageData!) : null,
//       'notes': notes,
//     };
// factory Item.fromJson(Map<String, dynamic> json) => Item(
//       id: json['id'] as int?,
//       createdAt: json['createdAt'] == null
//           ? null
//           : DateTime.parse(json['createdAt'] as String),
//       name: json['name'] as String?,
//       colors: (json['colors'] as List<dynamic>?)
//           ?.map((e) => e as String)
//           .toList(),
//       brand: json['brand'] as String?,
//       category: json['category'] as String?,
//       looks: (json['looks'] as List<dynamic>?)
//           ?.map((e) => Look.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       isFavorite: json['isFavorite'] as bool?,
//       price: (json['price'] as num?)?.toDouble(),
//       userId: json['userId'] as int?,
//       imageLocalPath: json['imageLocalPath'] as String?,
//       // imageData: json['imageData'] != null
//       //     ? Uint8List.fromList(
//       //         (json['imageData'] as List<dynamic>)
//       //             .map((e) => e as int)
//       //             .toList(),
//       //       )
//       //     : null,
//       notes: json['notes'] as String?,
//       size: json['size'] as String?,
//       tags: (json['tags'] as List<dynamic>?)
//           ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
}
