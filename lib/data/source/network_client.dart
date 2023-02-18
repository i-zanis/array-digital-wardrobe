import 'dart:async';

import 'package:dio/dio.dart';

abstract class NetworkClient {
  Future<Response> get(String url);

  Future<Response> post(String url, dynamic data);

  Future<Response> put(String url, dynamic data);

  Future<Response> deleteById(String url);
}
