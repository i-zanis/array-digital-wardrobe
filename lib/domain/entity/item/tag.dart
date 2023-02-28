import 'package:Array_App/domain/entity/base_entity.dart';

class Tag extends BaseEntity {
  Tag({
    super.id,
    this.name,
  });

  Tag.empty() : super.empty();

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  String? name;
  String? description;

  Tag copyWith({
    String? name,
    String? description,
  }) {
    return Tag(
      id: id ?? super.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
