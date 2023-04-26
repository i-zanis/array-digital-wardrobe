import 'dart:io';

import 'package:Array_App/data/data_source/remote/remote_remove_bg_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final dataSource = RemoteBackgroundDataSource();

  test(
    'Test removeBackground with a sample image',
    () async {
      const imagePath = 'test/fixture/image/test-image.jpg';
      final inputImageFile = File(imagePath);
      final outputImageFile = await dataSource.removeBackground(imagePath);
      expect(outputImageFile, isA<File>());
      expect(outputImageFile.path, isNot(inputImageFile.path));
      final inputBytes = await inputImageFile.readAsBytes();
      final outputBytes = await outputImageFile.readAsBytes();
      expect(outputBytes, isNot(inputBytes));
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );

  test('Test removeBackground with a non-existing image', () async {
    const imagePath = 'non-existing-image.jpg';
    await expectLater(
      dataSource.removeBackground(imagePath),
      throwsA(isA<PathNotFoundException>()),
    );
  }, timeout: const Timeout(Duration(seconds: 10)));
}
