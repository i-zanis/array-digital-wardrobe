import 'dart:ui';

class Item {
  Item({
    this.id,
    required this.colors,
    this.brand,
    this.category,
    required this.looks,
    this.isFavorite,
    this.price,
    this.image,
    this.notes,
    this.size,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int,
      colors: json['colors'] as Set<String>,
      brand: json['brand'] as String,
      category: json['category'] as String,
      looks: json['look'] as List<String>,
      isFavorite: json['isFavorite'] as bool,
      price: json['price'] as double,
      image: json['image'] as Image,
      notes: json['notes'] as String,
      size: json['size'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['colors'] = colors;
    data['brand'] = brand;
    data['category'] = category;
    data['look'] = looks;
    data['isFavorite'] = isFavorite;
    data['price'] = price;
    data['image'] = image;
    data['notes'] = notes;
    data['size'] = size;
    return data;
  }

  int? id;
  Set<String> colors;
  String? brand;
  String? category;
  List<String> looks;
  bool? isFavorite;
  double? price;
  Image? image;
  String? notes;
  String? size;
}
