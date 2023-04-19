abstract class GenericException implements Exception {
  /// [message] Description of the error that occurred.
  /// [cause] Optional represents the underlying exception that caused this
  //exception to be thrown.
  const GenericException({required this.message, this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() {
    if (cause == null) {
      return message;
    } else {
      return '$message; caused by: $cause';
    }
  }
}
