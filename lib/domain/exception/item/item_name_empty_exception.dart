import 'item_exception.dart';

class ItemNameEmptyException extends ItemException {
  ItemNameEmptyException({required super.message, super.cause});
}
