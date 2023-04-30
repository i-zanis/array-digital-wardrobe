import 'dart:typed_data';

import 'package:Array_App/domain/entity/base_entity.dart';
import 'package:Array_App/domain/entity/entity.dart';
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
    this.isFavorite,
    this.price,
    this.userId,
    this.imageLocalPath,
    this.imageData,
    this.notes,
    this.size,
    this.tags,
  });

  Item.empty() : super.empty();

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  String toString() {
    return 'Item {'
        '  id: $id,'
        '  name: $name,'
        '  category: $category,'
        '  isFavorite: $isFavorite,'
        '  imageData: ${imageData != null ? 'Present' : 'Not present'},'
        '  tags: $tags'
        '}';
  }

  DateTime? createdAt;
  String? name;
  String? brand;
  String? size;
  List<String>? colors;
  List<Tag>? tags;
  Category? category;
  bool? isFavorite = false;
  double? price;
  int? userId;
  String? imageLocalPath;
  @Uint8ListConverter()
  Uint8List? imageData;
  String? notes;

  Item copyWith({
    String? id,
    DateTime? createdAt,
    String? name,
    String? brand,
    String? size,
    List<String>? colors,
    List<Tag>? tags,
    Category? category,
    bool? isFavorite,
    double? price,
    int? userId,
    String? imageLocalPath,
    Uint8List? imageData,
    String? notes,
  }) {
    return Item(
      id: super.id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      size: size ?? this.size,
      colors: colors ?? this.colors,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      price: price ?? this.price,
      userId: userId ?? this.userId,
      imageLocalPath: imageLocalPath ?? this.imageLocalPath,
      imageData: imageData ?? this.imageData,
      notes: notes ?? this.notes,
    );
  }
}
