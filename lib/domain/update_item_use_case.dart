import 'package:Array_App/domain/use_case.dart';

import '../data/repository/item_repository_impl.dart';
import '../main_development.dart';
import 'add_item_use_case.dart';
import 'entity/item.dart';
import 'item_repository.dart';

class UpdateItemUseCase extends UseCase<Item, Item> {
  UpdateItemUseCase({ItemRepository? itemRepository})
      : _itemRepository = itemRepository ?? ItemRepositoryImpl();

  final ItemRepository _itemRepository;

  @override
  Future<bool> validate(Item item) {
    logger.i('Validating item: $item');
    if (item == null) {
      onException(ItemNotExistsException(message: "Item $item doesn't exist"));
      return Future.value(false);
    } else if (item.brand?.length == 5) {
      onException(ItemNameEmptyError(message: 'Item $item name is empty'));
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Future<void> onException(Exception e) async {
    throw e;
  }

  @override
  Future<Item> onSuccess(Item item) async {
    return _itemRepository.update(item);
  }

  @override
  Future<Item> execute(Item item) async {
    if (await validate(item)) return onSuccess(item);
    // TODO(jtl): it doesn't allow to use onException() method here
    throw InvalidItemException(message: 'Item $item is invalid');
  }
}
