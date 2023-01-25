import 'package:wardrobe_frontend/domain/entity/user.dart';

abstract class UserRepository {
  Future<User> findById({required int id});

  Future<void> delete({required int id});

  Future<void> save({required User user});

  Future<void> update({required User user});
}
