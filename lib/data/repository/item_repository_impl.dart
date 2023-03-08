import 'dart:async';

import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/domain/repository/item_repository.dart';
import 'package:Array_App/main_development.dart';
import 'package:Array_App/rest/util/util_functions.dart';

import '../data_source/local/local_item_data_source.dart';
import '../data_source/remote/remote_item_data_source.dart';

class ItemRepositoryImpl implements ItemRepository {
  factory ItemRepositoryImpl() {
    return _singleton;
  }

  ItemRepositoryImpl._internal()
      : _localDataSource = LocalItemDataSource(),
        _remoteDataSource = RemoteItemDataSource();
  static final ItemRepositoryImpl _singleton = ItemRepositoryImpl._internal();

  final LocalItemDataSource _localDataSource;
  final RemoteItemDataSource _remoteDataSource;
  final Duration _timeToLive = const Duration(seconds: 5);
  DateTime _lastUpdate = DateTime(0);
  int? _userId;

  @override
  Future<void> deleteById(int id) async {
    logger.i('$ItemRepositoryImpl: Deleting item with id: $id');
    await _localDataSource.delete(id);
    await _remoteDataSource.deleteById(id);
  }

  @override
  Future<List<Item>> findAll(int userId) async {
    if (_isStale()) {
      await _refreshData(userId);
    }
    logger.i('$ItemRepositoryImpl Retrieving all items');
    return _localDataSource.findAll();
  }

  @override
  Future<Item> findById(int id) async {
    logger.i('$ItemRepositoryImpl: Retrieving item with id: $id');
    if (_isStale()) {
      final item = _remoteDataSource.findById(id) as Item;
      await _localDataSource.save(item);
    }
    return _localDataSource.findById(id);
  }

// Save the item to both local/remote
  @override
  Future<Item> save(Item item) async {
    logger.i('$ItemRepositoryImpl: Saving item: $item');
    final savedItem = await _remoteDataSource.save(item);
    await _localDataSource.save(savedItem);
    return savedItem;
  }

  // Update the item in both local and remote data sources
  @override
  Future<Item> update(Item item) async {
    logger.i('$ItemRepositoryImpl: Updating item: $item');
    final updatedItem = await _remoteDataSource.update(item);
    await _localDataSource.update(updatedItem);
    return updatedItem;
  }

// Fetch from remote, save to local and update last update time
  Future<void> _refreshData(int userId) async {
    logger.i('$ItemRepositoryImpl: Refreshing data... with userId: $userId');
    final remoteItems = await _remoteDataSource.findAll(userId);
    await _localDataSource.saveAll(remoteItems);
    _lastUpdate = DateTime.now();
  }

  bool _isStale() {
    return isStale(_lastUpdate, _timeToLive);
  }
}
