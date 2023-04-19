import 'package:Array_App/config/config.dart';
import 'package:Array_App/data/network/network_client.dart';
import 'package:Array_App/data/network/network_client_factory.dart';
import 'package:Array_App/domain/entity/item/look.dart';
import 'package:Array_App/domain/exception/look/look_exception.dart';
import 'package:Array_App/main_development.dart';

class RemoteLookDataSource {
  RemoteLookDataSource({NetworkClient? networkClient, String? baseUrl})
      : _client = networkClient ?? NetworkClientFactory.create(),
        _baseUrl = baseUrl ?? Config.lookApiUrl;

  final NetworkClient _client;
  final String _baseUrl;

  Future<Look> findById(int id) async {
    logger.i('$RemoteLookDataSource: Retrieving look with id: $id');
    final response = await _client.get('$_baseUrl/$id');
    return Look.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Look> save(Look look) async {
    logger.i('$RemoteLookDataSource: Saving look: $look');
    final response = await _client.post(_baseUrl, look.toJson());
    if (response.statusCode == 201) {
      logger.d('$RemoteLookDataSource response: ${response.data}');
      return Look.fromJson(response.data as Map<String, dynamic>);
    }
    throw Exception(LookException(message: 'Error saving look'));
  }

  Future<Look> update(Look look) async {
    logger.i('$RemoteLookDataSource: Updating look: $look');
    final response = await _client.put(
      '$_baseUrl/${look.id}',
      look.toJson(),
    );
    if (response.statusCode == 200) {
      return Look.fromJson(response.data as Map<String, dynamic>);
    }
    throw Exception(LookException(message: 'Error updating look'));
  }

  Future<void> deleteById(int id) async {
    logger.i('$RemoteLookDataSource: Deleting look with id: $id');
    await _client.deleteById('$_baseUrl/$id');
  }

  Future<List<Look>> findAll(int userId) async {
    logger.i('$RemoteLookDataSource: Retrieving all looks for user: $userId');
    final response = await _client.get('$_baseUrl/all/$userId');
    logger.d('RemoteLookDataSource: response: $response');
    final data = await response.data as List<dynamic>;
    final looks =
        data.map((i) => Look.fromJson(i as Map<String, dynamic>)).toList();
    return looks;
  }
}
