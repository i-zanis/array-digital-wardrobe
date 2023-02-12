import 'dart:ui';

// @JsonSerializable()
class Item {
  Item.onlyUser(
      this.id,
      this.colors,
      this.brand,
      this.category,
      this.looks,
      this.isFavorite,
      this.price,
      this.userId,
      this.image,
      this.notes,
      this.size);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int?,
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      brand: json['brand'] as String?,
      category: json['category'] as String?,
      looks:
          (json['looks'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isFavorite: json['isFavorite'] as bool?,
      price: json['price'] as double?,
      image: json['image'] as Image?,
      notes: json['notes'] as String?,
      size: json['size'] as String?,
      userId: json['userId'] as int?,
    );
  }

  Map<String, dynamic> itemToJson(Item instance) => <String, dynamic>{
        'id': instance.id,
        'colors': instance.colors,
        'brand': instance.brand,
        'category': instance.category,
        'looks': instance.looks,
        'isFavorite': instance.isFavorite,
        'price': instance.price,
        'notes': instance.notes,
        'size': instance.size,
      };

  // factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  // Map<String, dynamic> toJson() => _$ItemToJson(this);

  // TODO(jtl) - add image potential schema change
  // class Item {
  // final String imageURL;
  // final String imagePath;

  int? id;
  List<String>? colors;
  String? brand;
  String? category;
  List<String>? looks;
  bool? isFavorite = false;
  double? price;
  int? userId;

  // @JsonKey(ignore: true)
  Image? image;
  String? notes;
  String? size;

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
    data['userId'] = userId;
    return data;
  }

  Item({
    this.id,
    this.colors,
    this.brand,
    this.category,
    this.looks,
    this.isFavorite,
    this.price,
    required this.userId,
    this.image,
    this.notes,
    this.size,
  });
}

// class Item {
//   final String name;
//   final String brand;
//   final String size;
//   final String color;
//   final String imagePath;
//   final Uint8List imageData;
//
//   Item({
//     this.name,
//     this.brand,
//     this.size,
//     this.color,
//     this.imagePath,
//     this.imageData,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       name: json['name'],
//       brand: json['brand'],
//       size: json['size'],
//       color: json['color'],
//       imagePath: json['image_path'],
//       imageData: base64Decode(json['image_data']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'brand': brand,
//       'size': size,
//       'color': color,
//       'image_path': imagePath,
//       'image_data': base64Encode(imageData),
//     };
//   }
// }
