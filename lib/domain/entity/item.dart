import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Item {
  Item({
    this.id,
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        name: json['name'] as String?,
        colors: (json['colors'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        brand: json['brand'] as String?,
        category: json['category'] as String?,
        looks:
            (json['looks'] as List<dynamic>?)?.map((e) => e as String).toList(),
        isFavorite: json['isFavorite'] as bool?,
        price: (json['price'] as num?)?.toDouble(),
        userId: json['userId'] as int?,
        imageLocalPath: json['imageLocalPath'] as String?,
        imageData: (json['imageData'] is List<int>)
            ? Uint8List.fromList(json['imageData'] as List<int>)
            : null,
        notes: json['notes'] as String?,
        size: json['size'] as String?,
        tags:
            (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      );

  int? id;
  DateTime? createdAt;
  String? name;
  String? brand;
  String? size;
  List<String>? colors;
  List<String>? tags;
  String? category;
  List<String>? looks;
  bool? isFavorite = false;
  double? price;
  int? userId;
  String? imageLocalPath;
  Uint8List? imageData;
  String? notes;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'name': name,
        'brand': brand,
        'size': size,
        'colors': colors,
        'tags': tags,
        'category': category,
        'looks': looks,
        'isFavorite': isFavorite,
        'price': price,
        'userId': userId,
        'imageLocalPath': imageLocalPath,
        'imageData': imageData,
        'notes': notes,
      };
// factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
// Map<String, dynamic> toJson() => _$ItemToJson(this);
}

// factory Item.fromJson(Map<String, dynamic> json) {
// return Item(
// id: json['id'] as int?,
// createdAt: json['created_at'] as DateTime,
// name: json['name'] as String?,
// brand: json['brand'] as String?,
// colors:
// (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
// tags: (json['tag'] as List<dynamic>?)?.map((e) => e as String).toList(),
// category: json['category'] as String?,
// looks:
// (json['looks'] as List<dynamic>?)?.map((e) => e as String).toList(),
// isFavorite: json['isFavorite'] as bool?,
// price: json['price'] as double?,
// userId: json['user'] as int?,
// imageLocalPath: json['image'] as String?,
// imageData: json['image'] as Uint8List,
// notes: json['notes'] as String?,
// size: json['size'] as String?,
// );
// }
//
// Map<String, dynamic> toJson(Item instance) => <String, dynamic>{
// 'id': instance.id,
// 'created_at': instance.createdAt,
// 'name': instance.name,
// 'brand': instance.brand,
// 'size': instance.size,
// 'colors': instance.colors?.toList(),
// 'price': instance.price,
// 'category': instance.category,
// 'looks': instance.looks?.toList(),
// 'isFavorite': instance.isFavorite,
// 'notes': instance.notes,
// 'user': instance.userId,
// 'imageLocalPath': instance.imageLocalPath,
// 'imageData': instance.imageData,
// 'tag': instance.tags?.toList(),
// };
