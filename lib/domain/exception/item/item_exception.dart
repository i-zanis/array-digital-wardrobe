import 'package:Array_App/domain/exception/abstract_generic_exception.dart';

class ItemException extends GenericException {
  ItemException({required super.message, super.cause});
}
