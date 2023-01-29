import 'package:wardrobe_frontend/domain/entity/item.dart';

abstract class ItemRepository {
  Future<List<Item>> findAll(int id);

  Future<Item> findById(int id);

  Future<void> delete(int id);

  Future<void> save(Item item);

  Future<void> saveAll(List<Item> items);

  Future<void> update(Item item);
}
