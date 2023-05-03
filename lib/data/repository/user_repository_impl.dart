import 'package:Array_App/domain/entity/user/user.dart';
import 'package:Array_App/domain/repository/user_repository.dart';
import 'package:Array_App/rest/util/util_functions.dart';

import '../data_source/local/local_user_data_source.dart';
import '../data_source/remote/remote_user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
    this._localUserDataSource,
    this._remoteUserDatasource,
    this._lastUpdate,
    this.userId,
  );

  final LocalUserDataSource _localUserDataSource;
  final RemoteUserDatasource _remoteUserDatasource;
  final Duration _timeToLive = const Duration(days: 300);
  DateTime _lastUpdate;
  int? userId;

  @override
  Future<User> findById(int id) async {
    if (_isStale()) {
      await _refreshData();
    }
    return _localUserDataSource.get();
  }

  @override
  Future<void> save(User user) async {
    final remoteUser = await _remoteUserDatasource.save(user);
    await _localUserDataSource.save(remoteUser);
    _lastUpdate = DateTime.now();
  }

  @override
  Future<void> update(User user) async {
    final remoteUser = await _remoteUserDatasource.update(user);
    await _localUserDataSource.save(remoteUser);
    _lastUpdate = DateTime.now();
  }

  bool _isStale() {
    return isStale(_lastUpdate, _timeToLive);
  }

  Future<void> _refreshData() async {
    final remoteUser = await _remoteUserDatasource.findById(userId);
    await _localUserDataSource.save(remoteUser);
    _lastUpdate = DateTime.now();
  }
}
