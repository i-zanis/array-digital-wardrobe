import 'package:Array_App/data/repository/item_repository_impl.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/domain/exception/item/invalid_item_exception.dart';
import 'package:Array_App/domain/repository/item_repository.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';

import '../../exception/item/item_not_found_exception.dart';

class UpdateItemUseCase extends UseCase<Item, Item> {
  UpdateItemUseCase({ItemRepository? itemRepository})
      : _itemRepository = itemRepository ?? ItemRepositoryImpl();

  final ItemRepository _itemRepository;

  @override
  Future<bool> validate(Item item) {
    logger.i('Validating item: $item');
    if (item == null) {
      throw ItemNotFoundException(message: "Item $item doesn't exist");
    }
    return Future.value(true);
  }

  @override
  Future<Item> execute(Item item) async {
    if (await validate(item)) return _itemRepository.update(item);
    throw InvalidItemException(message: 'Item $item is invalid');
  }
}
