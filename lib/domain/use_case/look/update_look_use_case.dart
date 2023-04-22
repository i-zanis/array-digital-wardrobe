import 'package:Array_App/domain/exception/look/look_exception.dart';

import '../../../data/repository/look_repository_impl.dart';
import '../../entity/item/look.dart';
import '../../repository/look_repository.dart';
import '../abstract_use_case.dart';

class UpdateLookUseCase extends UseCase<Look, Look> {
  UpdateLookUseCase({LookRepository? lookRepository})
      : _lookRepository = lookRepository ?? LookRepositoryImpl();

  final LookRepository _lookRepository;

  @override
  Future<void> validate(Look look) async {
    if (look == null) {
      throw LookException(message: 'Look is null');
    }
    if (look.items == null || look.items!.isEmpty) {
      throw LookException(message: 'Look items are null or empty');
    }
  }

  @override
  Future<Look> execute(Look look) async {
    await validate(look);
    return _lookRepository.update(look);
  }
}
