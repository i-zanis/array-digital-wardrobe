import 'package:Array_App/data/repository/item_repository_impl.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/domain/exception/user/invalid_user_id_exception.dart';
import 'package:Array_App/domain/repository/item_repository.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';

class InitialItemLoadUseCase extends UseCase<List<Item>, int> {
  InitialItemLoadUseCase({ItemRepository? itemRepository})
      : _itemRepository = itemRepository ?? ItemRepositoryImpl();
  final ItemRepository _itemRepository;

  @override
  Future<List<Item>> execute(int userId) async {
    logger.i('$InitialItemLoadUseCase execute with userId: $userId');
    await validate(userId);
    return _itemRepository.findAll(userId);
  }

  // TODO(jtl): to add more validation
  @override
  Future<void> validate(int userId) async {
    if (userId < 0) {
      throw InvalidUserIdException(message: "User id can't be negative");
    }
  }
}
