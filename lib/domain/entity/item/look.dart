import 'package:Array_App/domain/entity/base_entity.dart';

class Look extends BaseEntity {
  Look({
    super.id,
    this.name,
    this.description,
  });

  Look.empty() : super.empty();

  factory Look.fromJson(Map<String, dynamic> json) {
    return Look(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}
