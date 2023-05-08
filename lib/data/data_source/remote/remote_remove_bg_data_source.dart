import 'dart:io';

import 'package:dio/dio.dart';

import '../../../config/config.dart';
import '../../../main_development.dart';
import '../../network/network_client.dart';
import '../../network/network_client_factory.dart';

class RemoteRemoveBgDataSource {
  RemoteRemoveBgDataSource({NetworkClient? client, String? baseUrl})
      : _client = client ?? NetworkClientFactory.create(),
        _baseUrl = baseUrl ?? Config.removeBackgroundService;

  final NetworkClient _client;
  final String _baseUrl;

  Future<File> removeBackground(String imageFilePath) async {
    logger.i('$RemoteRemoveBgDataSource removing background from image');
    final imageFile = File(imageFilePath);
    final outputFile = File('${imageFile.path}_no_bg.png');

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFilePath),
    });

    try {
      final response = await _client.postMultiPart(
        _baseUrl,
        formData,
        {},
      );
      if (response.statusCode == 200) {
        await outputFile.writeAsBytes(response.data as List<int>);
        return outputFile;
      } else {
        throw Exception('Failed to remove background from image');
      }
    } catch (e) {
      logger
        ..e('$RemoteRemoveBgDataSource: $e')
        ..e('$RemoteRemoveBgDataSource: returning original image file');
      return imageFile;
    }
  }
}
