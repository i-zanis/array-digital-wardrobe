import 'package:Array_App/domain/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag extends BaseEntity {
  Tag({
    super.id,
    this.name,
  });

  Tag.empty() : super.empty();

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
  String? name;
  String? description;
}
