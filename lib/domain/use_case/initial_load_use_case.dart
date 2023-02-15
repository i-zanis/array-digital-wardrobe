import 'package:Array_App/data/repository/item_repository_impl.dart';
import 'package:Array_App/domain/item_repository.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';

import '../entity/item.dart';

class InitialLoadUseCase extends UseCase<List<Item>, int> {
  InitialLoadUseCase({ItemRepository? itemRepository})
      : _itemRepository = itemRepository ?? ItemRepositoryImpl();
  final ItemRepository _itemRepository;

  @override
  Future<List<Item>> execute(int userId) async {
    logger.i('$InitialLoadUseCase execute with userId: $userId');
    if (await validate(userId)) return onSuccess(userId);
    await onException(InvalidUserIdError(message: 'Invalid userId: $userId'));
    return [];
  }

  @override
  Future<void> onException(Exception e) async {
    throw e;
  }

  @override
  Future<List<Item>> onSuccess(int userId) async {
    final items = await _itemRepository.findAll(userId);
    if (items.length > 50) return items.sublist(0, 50);
    return items;
  }

  @override
  Future<bool> validate(int userId) async {
    if (userId == null) {
      throw InvalidUserIdError(message: 'Invalid userId: $userId');
    }
    return true;
  }
}

class UserException implements Exception {
  UserException({required this.message});

  final String message;
}

class InvalidUserIdError extends UserException {
  InvalidUserIdError({required super.message});
}
