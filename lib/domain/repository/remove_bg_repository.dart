import 'dart:io';

abstract class RemoveBackgroundRepository {
  Future<File> removeBackground(String imageFilePath);
}
