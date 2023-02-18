import 'package:Array_App/domain/exception/user/user_exception.dart';

class UserNotFoundException extends UserException {
  UserNotFoundException({required super.message});
}
