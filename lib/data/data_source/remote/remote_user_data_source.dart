import 'package:Array_App/domain/entity/user/user.dart';

class RemoteUserDatasource {
  Future<User> findById(int? userId) async {
    return User(firstName: 'test', email: 'test@test.com');
  }

  Future<User> update(User user) async {
    return User(firstName: 'test', email: 'test@test.com');
  }

// todo: add save method
  Future<User> save(User user) async {
    return User(firstName: 'test', email: 'test@test.com');
  }
}
