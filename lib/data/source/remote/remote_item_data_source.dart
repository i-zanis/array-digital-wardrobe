import 'package:Array_App/config/config.dart';
import 'package:Array_App/main_development.dart';
import 'package:dio/dio.dart';

import '../../../domain/entity/item.dart';

class RemoteItemDataSource {
  RemoteItemDataSource({Dio? networkClient, String? baseUrl})
      : networkClient = networkClient ?? Dio(),
        _baseUrl = baseUrl ?? Config.itemsUrl;

  final Dio networkClient;
  final String _baseUrl;

// Future<List<Item>> findAll() async {
//   try {
//     final response = await _dio.get<List>(_baseUrl);
//     return response.data.map((e) => Item.fromJson(e)).toList();
//   } on DioError catch (e) {
//     throw _handleError(e);
//   }
// }

  Future<Item> findById(int id) async {
    try {
      final response = await networkClient.get('$_baseUrl/$id');
      return Item.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> save(Item item) async {
    try {
      await networkClient.post<String>(_baseUrl, data: item.toJson());
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> update(Item item) async {
    try {
      await networkClient.patch('$_baseUrl/${item.id}', data: item.toJson());
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> delete(int? id) async {
    try {
      await networkClient.delete('$_baseUrl/$id');
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Item>> findAll(int userId) async {
    logger.d('RemoteItemDataSource: Retrieving all items with userId: $userId');
    try {
      final response = await networkClient.get('$_baseUrl/all/$userId');
      logger.d('RemoteItemDataSource: response: $response');
      final data = await response.data as List<dynamic>;
      final items =
          data.map((i) => Item.fromJson(i as Map<String, dynamic>)).toList();
      return items;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioError error) {
    logger.e('RemoteItemDataSource: Error: $error');
    final statusCode = error.response?.statusCode;
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return Exception(
            'The connection timed out. Please check your internet connection and try again later.');
      case DioErrorType.sendTimeout:
        return Exception(
            'The request timed out while sending. Please try again later.');
      case DioErrorType.receiveTimeout:
        return Exception(
            'The response timed out while receiving. Please try again later.');
      case DioErrorType.response:
        if (statusCode == 404) {
          return Exception(
              'The requested resource could not be found. Please check the URL and try again.');
        } else if (statusCode! >= 500 && statusCode < 600) {
          return Exception('A server error occurred. Please try again later.');
        } else {
          return Exception(
            'An error occurred while processing the request. Please try again later.',
          );
        }
      case DioErrorType.cancel:
        return Exception('The request was cancelled by the client.');
      case DioErrorType.other:
        return Exception('An unknown error occurred: $error');
    }
  }
}
