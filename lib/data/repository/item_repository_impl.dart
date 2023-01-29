import 'dart:async';

import 'package:wardrobe_frontend/data/source/local/local_item_data_source.dart';
import 'package:wardrobe_frontend/data/source/remote/remote_item_data_source.dart';
import 'package:wardrobe_frontend/domain/entity/item.dart';
import 'package:wardrobe_frontend/domain/item_repository.dart';
import 'package:wardrobe_frontend/rest/util/util_functions.dart';

class ItemRepositoryImpl extends ItemRepository {
  ItemRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  final LocalItemDataSource _localDataSource;
  final RemoteItemDataSource _remoteDataSource;
  final Duration _timeToLive = const Duration(seconds: 5);
  DateTime _lastUpdate = DateTime.now();

  @override
  Future<void> delete(int id) async {
    await _localDataSource.delete(id);
    await _remoteDataSource.delete(id);
  }

  @override
  Future<List<Item>> findAll(int id) async {
    if (_isStale()) await _refreshData();
    return _localDataSource.findAll();
  }

  @override
  Future<Item> findById(int id) async {
    // Check if the data is expired
    if (_isStale()) await _refreshData();
    return _localDataSource.findById(id);
  }

// Save the item to both local/remote
  @override
  Future<void> save(Item item) async {
    await _localDataSource.save(item);
    await _remoteDataSource.save(item);
  }

  @override
  Future<void> update(Item item) async {
    // Update the item in both local and remote data sources
    await _localDataSource.update(item);
    await _remoteDataSource.update(item);
  }

// Fetch from remote, save to local and update last update time
  Future<void> _refreshData() async {
    final remoteItems = await _remoteDataSource.findAll();
    await _localDataSource.saveAll(remoteItems);
    _lastUpdate = DateTime.now();
  }

  bool _isStale() {
    return isStale(_lastUpdate, _timeToLive);
  }

  @override
  Future<void> saveAll(List<Item> items) {
    // TODO: implement saveAll
    throw UnimplementedError();
  }
}
