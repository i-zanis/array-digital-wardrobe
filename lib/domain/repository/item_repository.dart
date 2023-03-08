import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/domain/repository/repository.dart';

abstract class ItemRepository implements Repository {
  Future<List<Item>> findAll(int userId);

  Future<Item> findById(int id);

  Future<void> deleteById(int id);

  Future<Item> save(Item item);

  Future<Item> update(Item item);
}
