import 'package:wardrobe_frontend/domain/entity/item.dart';
import 'package:wardrobe_frontend/domain/entity/preferences.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.preferences,
    required this.password,
    required this.items,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      preferences:
          Preferences.fromJson(json['preferences'] as Map<String, dynamic>),
      password: json['password'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  int id;
  String name;
  String email;
  Preferences preferences;
  String password;
  List<Item> items;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['preferences'] = preferences;
    data['password'] = password;
    data['items'] = items.map((i) => i.toJson()).toList();
    return data;
  }
}
