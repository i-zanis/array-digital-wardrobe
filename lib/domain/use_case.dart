abstract class UseCase<T, E> {
  Future<T> execute(E e);

  Future<bool> validate(E e);

  Future<void> onException(Exception e);

  Future<T> onSuccess(E e);
}
