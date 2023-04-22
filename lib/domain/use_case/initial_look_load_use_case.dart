import 'package:Array_App/data/repository/look_repository_impl.dart';
import 'package:Array_App/domain/entity/item/look.dart';
import 'package:Array_App/domain/exception/user/invalid_user_id_exception.dart';
import 'package:Array_App/domain/repository/look_repository.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';

class InitialLookLoadUseCase extends UseCase<List<Look>, int> {
  InitialLookLoadUseCase({LookRepository? lookRepository})
      : _lookRepository = lookRepository ?? LookRepositoryImpl();
  final LookRepository _lookRepository;

  @override
  Future<List<Look>> execute(int userId) async {
    logger.i('$InitialLookLoadUseCase execute with userId: $userId');
    await validate(userId);
    return _lookRepository.findAll(userId);
  }

  @override
  Future<void> validate(int userId) async {
    if (userId < 0) {
      throw InvalidUserIdException(message: "User id can't be negative");
    }
  }
}
