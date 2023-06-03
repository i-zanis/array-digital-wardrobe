import 'package:Array_App/data/network/dio_exception_handler.dart';
import 'package:Array_App/data/network/network_client.dart';
import 'package:dio/dio.dart';

class DioNetworkClient implements NetworkClient {
  DioNetworkClient() {
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
  }

  static final Dio _dio = Dio();

  @override
  Future<Response<dynamic>> get(String url) async {
    try {
      return await _dio.get(url);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response<dynamic>> post(String url, dynamic data) async {
    try {
      return await _dio.post(url, data: data as dynamic);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response<List<int>>> postMultiPart(
    String url,
    dynamic data,
    Map<String, dynamic> headers,
  ) async {
    try {
      return await _dio.post<List<int>>(
        url,
        data: data as FormData,
        options: Options(
          headers: headers,
          contentType: 'multipart/form-data',
          responseType: ResponseType.bytes,
        ),
      );
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response<dynamic>> put(String url, dynamic data) async {
    try {
      return await _dio.put(url, data: data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response<dynamic>> deleteById(String url) async {
    try {
      return await _dio.delete(url);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  DioExceptionHandler _handleError(DioError e) {
    return handleError(e);
  }
}
