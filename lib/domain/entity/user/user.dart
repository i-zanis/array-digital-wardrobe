import 'package:Array_App/domain/entity/base_entity.dart';
import 'package:Array_App/domain/entity/user/preferences.dart';

class User extends BaseEntity {
  User({
    super.id,
    this.firstName,
    this.lastName,
    this.email,
    this.createdAt,
    this.preferences,
  });

  User.empty() : super.empty();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      createdAt: json['createdAt'] as DateTime,
      preferences: json['preferences'] as Preferences,
    );
  }

  String? firstName;
  String? lastName;
  String? email;
  DateTime? createdAt;
  Preferences? preferences;

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': createdAt,
      'preferences': preferences,
    };
  }

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? createdAt,
    Preferences? preferences,
  }) {
    return User(
      id: id ?? super.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      preferences: preferences ?? this.preferences,
    );
  }
}
