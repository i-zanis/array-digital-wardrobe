import 'package:Array_App/data/source/network_client.dart';
import 'package:dio/dio.dart';

class DioNetworkClient implements NetworkClient {
  DioNetworkClient() {
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 5000;
    // _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  static final Dio _dio = Dio();

  @override
  Future<Response> get(String url) async {
    try {
      return await _dio.get(url);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> post(String url, dynamic data) async {
    try {
      return await _dio.post(url, data: data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> put(String url, dynamic data) async {
    try {
      return await _dio.put(url, data: data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> deleteById(String url) async {
    try {
      return await _dio.delete(url);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioError error) {
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
