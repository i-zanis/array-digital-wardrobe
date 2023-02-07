import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe_frontend/domain/entity/item.dart';
import 'package:wardrobe_frontend/main_development.dart';

class LocalItemDataSource {
  factory LocalItemDataSource() {
    return _singleton;
  }

  // _internal is a private constructor You can create any private constructor
  // using any Class._someName construction
  LocalItemDataSource._internal();

  static final LocalItemDataSource _singleton = LocalItemDataSource._internal();
  static final SharedPreferences? _prefs = sharedPrefs;
  static const String _itemsKey = 'items';

  Future<void> saveAll(List<Item> items) async {
    final itemsJson = items.map((item) => item.toJson()).toList();
    logger.i('LocalItemDataSource: Saving all items: $itemsJson');
    await _prefs?.setStringList(
        _itemsKey, itemsJson.map((e) => json.encode(e)).toList());
  }

  Future<void> save(Item item) async {
    final items = await findAll();
    logger.i('LocalItemDataSource: Saving item: ${item.toJson()}');
    final itemsWithoutUpdated = items.where((i) => item.id != i.id).toList()
      ..add(item);
    await saveAll(itemsWithoutUpdated);
  }

  Future<List<Item>> findAll() async {
    logger.d('$LocalItemDataSource: Retrieving all items');
    final itemsJson = _prefs?.getStringList(_itemsKey);
    if (itemsJson == null) {
      logger.i('No items found in local storage');
      return [];
    }
    return itemsJson
        .map((item) => Item.fromJson(json.decode(item) as Map<String, dynamic>))
        .toList();
  }

  Future<void> delete(int id) async {
    logger.i('LocalItemDataSource: Deleting item with id: $id');
    final items = await findAll();
    final itemsWithoutDeleted = items.where((i) => id != i.id).toList();
    await saveAll(itemsWithoutDeleted);
  }

  Future<void> update(Item item) async {
    logger.i('LocalItemDataSource: Updating item: ${item.toJson()}');
    final items = await findAll();
    final itemsWithoutUpdated = items.where((i) => item.id != i.id).toList()
      ..add(item);
    await saveAll(itemsWithoutUpdated);
  }

  Future<Item> findById(int id) async {
    logger.d('LocalItemDataSource: Retrieving item with id: $id');
    final items = await findAll();
    final item = items.firstWhere((i) => id == i.id);
    return item;
  }
}
