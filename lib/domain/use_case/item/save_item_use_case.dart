import 'package:Array_App/data/repository/item_repository_impl.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/domain/exception/exception.dart';
import 'package:Array_App/domain/repository/item_repository.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';

class SaveItemUseCase extends UseCase<Item, Item> {
  SaveItemUseCase({ItemRepository? itemRepository})
      : _itemRepository = itemRepository ?? ItemRepositoryImpl();

  final ItemRepository _itemRepository;

  @override
  Future<void> validate(Item item) async {
    if (item == null) {
      throw ItemException(message: 'Item is null');
    }
  }

  @override
  Future<Item> execute(Item item) async {
    logger.i('$SaveItemUseCase execute with item: $item');
    await validate(item);
    return _itemRepository.save(item);
  }
}
