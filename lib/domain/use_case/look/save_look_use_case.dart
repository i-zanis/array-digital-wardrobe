import 'package:Array_App/data/repository/look_repository_impl.dart';
import 'package:Array_App/domain/entity/item/look.dart';
import 'package:Array_App/domain/exception/look/look_exception.dart';
import 'package:Array_App/domain/repository/look_repository.dart';
import 'package:Array_App/domain/use_case/abstract_use_case.dart';
import 'package:Array_App/main_development.dart';

class SaveLookUseCase extends UseCase<Look, Look> {
  SaveLookUseCase({LookRepository? lookRepository})
      : _lookRepository = lookRepository ?? LookRepositoryImpl();

  final LookRepository _lookRepository;

  @override
  Future<void> validate(Look look) async {
    if (look.id != null) {
      throw LookException(message: 'Look id must be null for new look');
    }
  }

  @override
  Future<Look> execute(Look look) async {
    logger.i('$SaveLookUseCase execute with look: $look');
    await validate(look);
    return _lookRepository.save(look);
  }
}
