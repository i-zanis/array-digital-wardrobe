import 'package:dio/dio.dart';
import 'package:wardrobe_frontend/domain/entity/item.dart';

class RemoteItemDataSource {
  RemoteItemDataSource({Dio? dio, String? baseUrl})
      : _dio = dio ?? Dio(),
        _baseUrl = baseUrl ?? 'http://localhost:8080/api/items';

  final Dio _dio;
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
      final response = await _dio.get('$_baseUrl/$id');
      return Item.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> save(Item item) async {
    try {
      await _dio.post<String>(_baseUrl, data: item.toJson());
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> update(Item item) async {
    try {
      await _dio.patch('$_baseUrl/${item.id}', data: item.toJson());
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> delete(int? id) async {
    try {
      await _dio.delete('$_baseUrl/$id');
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        // TODO(jtl): Handle this case.
        break;
      case DioErrorType.sendTimeout:
        // TODO(jtl): Handle this case.
        break;
      case DioErrorType.receiveTimeout:
        // TODO(jtl): Handle this case.
        break;
      case DioErrorType.response:
        // TODO(jtl): Handle this case.
        break;
      case DioErrorType.cancel:
        // TODO(jtl): Handle this case.
        break;
      case DioErrorType.other:
        // TODO(jtl): Handle this case.
        break;
    }
    return Exception();
  }

  Future<List<Item>> findAll(int? userId) async {
    return [];
  }
}
