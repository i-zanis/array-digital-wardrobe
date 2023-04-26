import 'dart:io';

import 'package:Array_App/data/data_source/remote/remote_remove_bg_data_source.dart';
import 'package:Array_App/domain/repository/remove_bg_repository.dart';
import 'package:Array_App/main_development.dart';

class RemoveBackgroundRepositoryImpl extends RemoveBackgroundRepository {
  factory RemoveBackgroundRepositoryImpl() {
    return _eagerInstance;
  }

  RemoveBackgroundRepositoryImpl._internal()
      : _remoteDataSource = RemoteBackgroundDataSource();
  static final RemoveBackgroundRepositoryImpl _eagerInstance =
      RemoveBackgroundRepositoryImpl._internal();

  final RemoteBackgroundDataSource _remoteDataSource;
  final Duration _timeToLive = const Duration(seconds: 5);
  DateTime _lastUpdate = DateTime(0);

  @override
  Future<File> removeBackground(String imageFilePath) {
    logger.i('$RemoveBackgroundRepositoryImpl: removeBackground');
    if (_isStale()) {
      _lastUpdate = DateTime.now();
      return _remoteDataSource.removeBackground(imageFilePath);
    }
    return Future.value(File(imageFilePath));
  }

  bool _isStale() => DateTime.now().difference(_lastUpdate) > _timeToLive;
}
