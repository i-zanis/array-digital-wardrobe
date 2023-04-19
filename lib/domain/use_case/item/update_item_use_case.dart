import 'package:Array_App/data/repository/item_repository_impl.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/domain/exception/item/item_not_found_exception.dart';
import 'package:Array_App/domain/repository/item_repository.dart';
import 'package:Array_App/domain/use_case/use_case.dart';

class UpdateItemUseCase extends UseCase<Item, Item> {
  UpdateItemUseCase({ItemRepository? itemRepository})
      : _itemRepository = itemRepository ?? ItemRepositoryImpl();

  final ItemRepository _itemRepository;

  @override
  Future<void> validate(Item item) async {
    if (item == null) {
      throw ItemNotFoundException(message: "Item $item doesn't exist");
    }
  }

  @override
  Future<Item> execute(Item item) async {
    await validate(item);
    return _itemRepository.update(item);
  }
}
