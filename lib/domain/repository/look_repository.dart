import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/domain/repository/repository.dart';

abstract class LookRepository implements Repository {
  Future<List<Look>> findAll(int userId);

  Future<Look> findById(int id);

  Future<void> deleteById(int id);

  Future<Look> save(Look look);

  Future<Look> update(Look look);
}
