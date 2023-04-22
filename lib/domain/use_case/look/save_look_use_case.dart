import '../../../data/repository/look_repository_impl.dart';
import '../../../main_development.dart';
import '../../entity/item/look.dart';
import '../../exception/look/look_exception.dart';
import '../../repository/look_repository.dart';
import '../abstract_use_case.dart';

class SaveLookUseCase extends UseCase<Look, Look> {
  SaveLookUseCase({LookRepository? lookRepository})
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
    logger.i('$SaveLookUseCase execute with look: $look');
    await validate(look);
    return _lookRepository.save(look);
  }
}
