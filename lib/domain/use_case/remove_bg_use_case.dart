import 'dart:io';

import 'package:Array_App/data/repository/remove_bg_repository.dart';
import 'package:Array_App/domain/exception/remove_bg_use_case_exception.dart';
import 'package:Array_App/domain/repository/remove_bg_repository.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';

class RemoveBackgroundUseCase extends UseCase<File, String> {
  RemoveBackgroundUseCase({
    RemoveBackgroundRepository? removeBackgroundRepository,
  }) : _removeBackgroundRepository =
            removeBackgroundRepository ?? RemoveBackgroundRepositoryImpl();

  final RemoveBackgroundRepository _removeBackgroundRepository;

  @override
  Future<File> execute(String imageFilePath) async {
    logger.i('$RemoveBackgroundUseCase execute image: $imageFilePath');
    // await validate(imageFilePath);
    return _removeBackgroundRepository.removeBackground(imageFilePath);
  }

  @override
  Future<void> validate(String imageFilePath) async {
    final sanitizedPath = imageFilePath.trim();
    if (sanitizedPath.isEmpty) {
      throw RemoveBackgroundUseCaseException(
        message: 'Image path is empty',
      );
    }
    if (_isInvalidImagePath(sanitizedPath)) {
      throw RemoveBackgroundUseCaseException(
        message: 'Image path contains invalid characters',
      );
    }
    if (_isInvalidImageFormat(sanitizedPath)) {
      throw RemoveBackgroundUseCaseException(
        message: 'Image format should be .jpg, .jpeg, .png or .bmp',
      );
    }
  }

  bool _isInvalidImagePath(String value) {
    return !RegExp(r'^[a-zA-Z0-9/\\_-]+$').hasMatch(value);
  }

  bool _isInvalidImageFormat(String imagePath) {
    final validExtensions = ['.jpg', '.jpeg', '.png', '.bmp'];
    final extensionIndex = imagePath.lastIndexOf('.');
    if (extensionIndex == -1) {
      return true;
    }
    final extensionName = imagePath.substring(extensionIndex).toLowerCase();
    return !validExtensions.contains(extensionName);
  }
}
