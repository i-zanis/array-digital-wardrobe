import 'package:Array_App/domain/exception/item/item_exception.dart';

class InvalidItemException extends ItemException {
  InvalidItemException({required super.message, super.cause});
}
