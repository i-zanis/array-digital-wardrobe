import 'dart:async';

import 'package:Array_App/domain/entity/item/item.dart';
import 'package:dio/dio.dart';

abstract class NetworkClient {
  Future<Response> get(String url);

  Future<Response<dynamic>> post(String url, dynamic data);

  Future<Response> put(String url, dynamic data);

  Future<Response> deleteById(String url);

  Future<Response> postMultipart(String url, Item item);
// Future<Response> postMultipart(String url, Map<String, dynamic> data);
}
