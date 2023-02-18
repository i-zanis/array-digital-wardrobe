import 'package:Array_App/data/repository/item_repository_impl.dart';
import 'package:Array_App/domain/entity/item.dart';
import 'package:Array_App/domain/exception/item/item_not_found_exception.dart';
import 'package:Array_App/domain/repository/item_repository.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';

class SaveItemUseCase extends UseCase<Item, Item> {
  SaveItemUseCase({ItemRepository? itemRepository})
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
    if (await validate(item)) return _itemRepository.save(item);
    throw ItemNotFoundException(message: "Item $item doesn't exist");
  }
}
