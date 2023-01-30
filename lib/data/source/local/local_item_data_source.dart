import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe_frontend/domain/entity/item.dart';

class LocalItemDataSource {
  LocalItemDataSource(this._prefs);

  static const String _itemsKey = 'items';
  final SharedPreferences _prefs;

  Future<void> save(List<Item> items) async {
    final itemsJson = items.map((item) => item.toJson()).toList();
    await _prefs.setStringList(_itemsKey, itemsJson.cast<String>());
  }

  Future<List<Item>> findAll() async {
    final itemsJson = _prefs.getStringList(_itemsKey);
    if (itemsJson == null) {
      return [];
    }
    return itemsJson
        .map((item) => Item.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> delete(int id) async {
    final items = await findAll();
    final itemsWithoutDeleted = items.where((i) => id != i.id).toList();
    await save(itemsWithoutDeleted);
  }

  Future<void> update(Item item) async {
    final items = await findAll();
    final itemsWithoutUpdated = items.where((i) => item.id != i.id).toList()
      ..add(item);
    await save(itemsWithoutUpdated);
  }
}
