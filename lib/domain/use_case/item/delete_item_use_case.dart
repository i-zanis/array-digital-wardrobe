import 'package:Array_App/data/repository/item_repository_impl.dart';
import 'package:Array_App/domain/exception/user/invalid_user_id_exception.dart';
import 'package:Array_App/domain/repository/item_repository.dart';
import 'package:Array_App/main_development.dart';

import '../use_case.dart';

class DeleteItemUseCase extends UseCase<void, int> {
  DeleteItemUseCase({ItemRepository? itemRepository})
      : _itemRepository = itemRepository ?? ItemRepositoryImpl();

  final ItemRepository _itemRepository;

  @override
  // TODO(jtl): maybe requires removal (over-engineering)
  Future<void> validate(int id) async {
    if (id < 0) {
      throw InvalidUserIdException(message: "User id can't be negative");
    }
  }

  @override
  Future<void> execute(int id) async {
    logger.i('$DeleteItemUseCase execute id: $id');
    await validate(id);
    await _itemRepository.deleteById(id);
  }
}
