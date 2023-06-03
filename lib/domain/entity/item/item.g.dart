// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String?,
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      brand: json['brand'] as String?,
      category: $enumDecodeNullable(_$CategoryEnumMap, json['category']),
      isFavorite: json['isFavorite'] as bool?,
      price: (json['price'] as num?)?.toDouble(),
      userId: json['userId'] as int?,
      imageLocalPath: json['imageLocalPath'] as String?,
      imageData:
          const Uint8ListConverter().fromJson(json['imageData'] as List?),
      notes: json['notes'] as String?,
      size: json['size'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'name': instance.name,
      'brand': instance.brand,
      'size': instance.size,
      'colors': instance.colors,
      'tags': instance.tags,
      'category': _$CategoryEnumMap[instance.category],
      'isFavorite': instance.isFavorite,
      'price': instance.price,
      'userId': instance.userId,
      'imageLocalPath': instance.imageLocalPath,
      'imageData': const Uint8ListConverter().toJson(instance.imageData),
      'notes': instance.notes,
    };

const _$CategoryEnumMap = {
  Category.TOP: 'TOP',
  Category.BOTTOM: 'BOTTOM',
  Category.SHOES: 'SHOES',
  Category.ACCESSORIES: 'ACCESSORIES',
  Category.INNERWEAR: 'INNERWEAR',
  Category.OTHER: 'OTHER',
};
