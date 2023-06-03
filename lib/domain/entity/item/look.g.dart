// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'look.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Look _$LookFromJson(Map<String, dynamic> json) => Look(
      id: json['id'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      lookImageData:
          const Uint8ListConverter().fromJson(json['lookImageData'] as List?),
      lookWithUserImageData: const Uint8ListConverter()
          .fromJson(json['lookWithUserImageData'] as List?),
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$LookToJson(Look instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'items': instance.items,
      'description': instance.description,
      'lookImageData':
          const Uint8ListConverter().toJson(instance.lookImageData),
      'lookWithUserImageData':
          const Uint8ListConverter().toJson(instance.lookWithUserImageData),
      'userId': instance.userId,
    };
