import 'dart:io';

import 'package:dio/dio.dart';

import '../../../config/config.dart';
import '../../../main_development.dart';
import '../../network/network_client.dart';
import '../../network/network_client_factory.dart';

// class RemoteBackgroundDataSource {
//   RemoteBackgroundDataSource({NetworkClient? client, String? baseUrl})
//       : _client = client ?? NetworkClientFactory.create(),
//         _baseUrl = baseUrl ?? Config.removeBackgroundService;
//
//   final NetworkClient _client;
//   final String _baseUrl;
//
//   Future<File> removeBackground(String imageFilePath) async {
//     logger.i('Removing background from image');
//     final imageFile = File(imageFilePath);
//     final outputFile = File('${imageFile.path}_no_bg.png');
//     final dio = Dio();
//
//     final formData = FormData.fromMap({
//       'file': await MultipartFile.fromFile(imageFilePath),
//     });
//
//     try {
//       final response = await dio.post<List<int>>(
//         _baseUrl,
//         data: formData,
//         options: Options(
//           responseType: ResponseType.bytes,
//         ),
//       );
//       if (response.statusCode == 200) {
//         await outputFile.writeAsBytes(response.data!);
//         return outputFile;
//       } else {
//         throw Exception('Failed to remove background from image');
//       }
//     } catch (e) {
//       logger.e(e);
//       return imageFile;
//     }
//   }

class RemoteBackgroundDataSource {
  RemoteBackgroundDataSource({NetworkClient? client, String? baseUrl})
      : _client = client ?? NetworkClientFactory.create(),
        _baseUrl = baseUrl ?? Config.removeBackgroundService;

  final NetworkClient _client;
  final String _baseUrl;

  Future<File> removeBackground(String imageFilePath) async {
    logger.i('Removing background from image');
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
      logger.e(e);
      return imageFile;
    }
  }
}

// Future<File> removeBackground(String imageFilePath) async {
//   logger.i('Removing background from image');
//   final imageFile = File(imageFilePath);
//   final outputFile = File('${imageFile.path}_no_bg.png');
//   final dio = Dio();
//
//   FormData formData = FormData.fromMap({
//     'file': await MultipartFile.fromFile(imageFilePath),
//   });
//
//   try {
//     Response response = await dio.post(
//       Config.removeBackgroundService,
//       data: formData,
//     );
//     if (response.statusCode == 200) {
//       logger.i('Background removed from image');
//       logger.i(response.data);
//       await outputFile
//           .writeAsBytes(base64Decode(base64response.data as String));
//       return outputFile;
//     } else {
//       throw Exception('Failed to remove background from image');
//     }
//   } catch (e) {
//     logger.e(e);
//     return imageFile;
//   }
// }

// Future<Uint8List> removeBackground(Uint8List uInt8List) async {
//   logger.i('$RemoteBackgroundDataSource: sending image..');
//   var image = await uInt8ListToImage(uInt8List);
//   var file = await File(image);
//   // final formData =
//   //     FormData.fromMap({'file': MultipartFile.fromFile(image.path)});
//
//   final tempDir = await getTemporaryDirectory();
//   final tempFile = File('${tempDir.path}/temp_image.png');
//   await tempFile.writeAsBytes(uInt8List);
//
//   // Create FormData with the temporary file
//   final formData = FormData.fromMap({
//     'file': await MultipartFile.fromFile(tempFile.path),
//   });
//   final response = await _client.post(_baseUrl, formData);
//   logger.i(
//     '$RemoteBackgroundDataSource: removeBackground response: $response',
//   );
//   final json = await jsonDecode(jsonEncode(response.data));
//   return json as Uint8List;
//
// }
