import 'package:Array_App/domain/exception/look/look_exception.dart';

import '../../../data/repository/look_repository_impl.dart';
import '../../../main_development.dart';
import '../../repository/look_repository.dart';
import '../abstract_use_case.dart';

class DeleteLookUseCase extends UseCase<void, int> {
  DeleteLookUseCase({LookRepository? lookRepository})
      : _lookRepository = lookRepository ?? LookRepositoryImpl();

  final LookRepository _lookRepository;

  @override
  Future<void> validate(int id) async {
    if (id < 0) {
      throw LookException(message: "Look id can't be negative");
    }
  }

  @override
  Future<void> execute(int id) async {
    logger.i('$DeleteLookUseCase execute id: $id');
    await validate(id);
    await _lookRepository.deleteById(id);
  }
}
