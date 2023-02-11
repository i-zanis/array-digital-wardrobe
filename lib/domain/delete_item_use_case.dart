import 'package:Array_App/domain/use_case.dart';

import '../data/repository/item_repository_impl.dart';
import '../main_development.dart';
import 'add_item_use_case.dart';
import 'item_repository.dart';

class DeleteItemUseCase extends UseCase<void, int> {
  DeleteItemUseCase({ItemRepository? itemRepository})
      : _itemRepository = itemRepository ?? ItemRepositoryImpl();

  final ItemRepository _itemRepository;

  @override
  // TODO(jtl): maybe requires removal (over-engineering)
  Future<bool> validate(int id) {
    if (id != null) return Future.value(true);
    return Future.value(false);
  }

  @override
  Future<void> onError(Error e) async {
    throw e;
  }

  @override
  Future<void> onSuccess(int id) async {
    await _itemRepository.delete(id);
  }

  @override
  Future<void> execute(int id) async {
    logger.i('$DeleteItemUseCase execute id: $id');
    if (await validate(id)) {
      await onSuccess(id);
    } else {
      await onError(ItemNotExists());
    }
  }
}
