import 'dart:async';

import 'package:dio/dio.dart';

abstract class NetworkClient {
  Future<Response<dynamic>> get(String url);

  Future<Response<dynamic>> post(String url, dynamic data);

  Future<Response<dynamic>> postMultiPart(
    // Change the return type here
    String url,
    dynamic data,
    Map<String, dynamic> headers,
  );

  Future<Response<dynamic>> put(String url, dynamic data);

  // TODO(jtl) - change to delete
  Future<Response<dynamic>> deleteById(String url);
}
