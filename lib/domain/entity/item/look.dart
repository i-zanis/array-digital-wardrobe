import 'package:Array_App/domain/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'look.g.dart';

@JsonSerializable()
class Look extends BaseEntity {
  Look({
    super.id,
    this.name,
    this.description,
  });

  Look.empty() : super.empty();

  factory Look.fromJson(Map<String, dynamic> json) => _$LookFromJson(json);

  Map<String, dynamic> toJson() => _$LookToJson(this);

  @override
  String toString() {
    return 'Look {id: $id, name: $name, description: $description}';
  }

  String? name;
  String? description;

  Look copyWith({
    String? name,
    String? description,
  }) {
    return Look(
      id: id ?? super.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
