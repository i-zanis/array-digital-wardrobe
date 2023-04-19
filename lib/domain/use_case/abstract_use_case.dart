abstract class UseCase<T, E> {
  Future<T> execute(E e);

  Future<void> validate(E e);
}
