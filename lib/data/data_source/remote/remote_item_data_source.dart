import 'package:Array_App/config/config.dart';
import 'package:Array_App/data/network/network_client.dart';
import 'package:Array_App/data/network/network_client_factory.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/domain/exception/item/item_exception.dart';
import 'package:Array_App/main_development.dart';

class RemoteItemDataSource {
  RemoteItemDataSource({NetworkClient? networkClient, String? baseUrl})
      : _client = networkClient ?? NetworkClientFactory.create(),
        _baseUrl = baseUrl ?? Config.itemApiUrl;

  final NetworkClient _client;
  final String _baseUrl;

  Future<Item> findById(int id) async {
    logger.i('$RemoteItemDataSource: Retrieving item with id: $id');
    final response = await _client.get('$_baseUrl/$id');
    return Item.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Item> save(Item item) async {
    logger.i('$RemoteItemDataSource: Saving item: $item');
    final response = await _client.post(_baseUrl, item.toJson());
    if (response.statusCode == 201) {
      logger.d('$RemoteItemDataSource response: ${response.data}');
      return Item.fromJson(response.data as Map<String, dynamic>);
    }
    throw Exception(ItemException(message: 'Error saving item'));
  }

  Future<Item> update(Item item) async {
    logger.i('$RemoteItemDataSource: Updating item: $item');
    final response = await _client.put(
      '$_baseUrl/${item.id}',
      item.toJson(),
    );
    if (response.statusCode == 200) {
      return Item.fromJson(response.data as Map<String, dynamic>);
    }
    throw Exception(ItemException(message: 'Error updating item'));
  }

  Future<void> deleteById(int id) async {
    logger.i('$RemoteItemDataSource: Deleting item with id: $id');
    await _client.deleteById('$_baseUrl/$id');
  }

  Future<List<Item>> findAll(int userId) async {
    logger.i('$RemoteItemDataSource: Retrieving all items for user: $userId');
    final response = await _client.get('$_baseUrl/all/$userId');
    logger.d('RemoteItemDataSource: response: $response');
    final data = await response.data as List<dynamic>;
    final items =
        data.map((i) => Item.fromJson(i as Map<String, dynamic>)).toList();
    return items;
  }
}
