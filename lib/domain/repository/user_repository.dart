import '../entity/user/user.dart';

abstract class UserRepository {
  Future<User> findById(int id);

  Future<void> save(User user);

  Future<void> update(User user);
}
