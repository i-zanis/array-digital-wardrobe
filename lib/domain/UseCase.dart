import 'package:wardrobe_frontend/domain/user_repository.dart';


abstract class UseCase<Type, Params> {
  Future<void> call(Params params);

  Future<Type> validate(Params params);

  Future<void> onError(Object error);

  Future<void> onSuccess(Type result);
}

