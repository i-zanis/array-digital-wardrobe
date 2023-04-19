import 'package:Array_App/domain/exception/abstract_generic_exception.dart';

class WeatherUseCaseException extends GenericException {
  WeatherUseCaseException({required super.message, super.cause});
}
