import 'dart:async';

import 'package:Array_App/data/data_source/local/local_look_data_source.dart';
import 'package:Array_App/data/data_source/remote/remote_look_data_source.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/domain/repository/look_repository.dart';
import 'package:Array_App/main_development.dart';
import 'package:Array_App/rest/util/util_functions.dart';

class LookRepositoryImpl implements LookRepository {
  factory LookRepositoryImpl() {
    return _singleton;
  }

  LookRepositoryImpl._internal()
      : _localDataSource = LocalLookDataSource(),
        _remoteDataSource = RemoteLookDataSource();
  static final LookRepositoryImpl _singleton = LookRepositoryImpl._internal();

  final LocalLookDataSource _localDataSource;
  final RemoteLookDataSource _remoteDataSource;
  final Duration _timeToLive = const Duration(seconds: 2);
  DateTime _lastUpdate = DateTime(0);
  int? _userId;

  @override
  Future<void> deleteById(int id) async {
    logger.i('$LookRepositoryImpl: Deleting look with id: $id');
    await _localDataSource.delete(id);
    await _remoteDataSource.deleteById(id);
  }

  @override
  Future<List<Look>> findAll(int userId) async {
    if (_isStale()) {
      await _refreshData(userId);
    }
    logger.i('$LookRepositoryImpl Retrieving all looks');
    return _localDataSource.findAll();
  }

  @override
  Future<Look> findById(int id) async {
    logger.i('$LookRepositoryImpl: Retrieving look with id: $id');
    if (_isStale()) {
      final look = _remoteDataSource.findById(id) as Look;
      await _localDataSource.save(look);
    }
    return _localDataSource.findById(id);
  }

  @override
  Future<Look> save(Look look) async {
    logger.i('$LookRepositoryImpl: Saving look: $look');
    final savedLook = await _remoteDataSource.save(look);
    await _localDataSource.save(savedLook);
    return savedLook;
  }

  @override
  Future<Look> update(Look look) async {
    logger.i('$LookRepositoryImpl: Updating look: $look');
    final updatedLook = await _remoteDataSource.update(look);
    await _localDataSource.update(updatedLook);
    return updatedLook;
  }

  Future<void> _refreshData(int userId) async {
    logger.i('$LookRepositoryImpl: Refreshing data... with userId: $userId');
    final remoteLooks = await _remoteDataSource.findAll(userId);
    await _localDataSource.saveAll(remoteLooks);
    _lastUpdate = DateTime.now();
  }

  bool _isStale() {
    return isStale(_lastUpdate, _timeToLive);
  }
}
