import 'package:dio/dio.dart';

class DioExceptionHandler implements Exception {
  DioExceptionHandler(this.message);

  final String message;

  @override
  String toString() => 'DioExceptionHandler: $message';
}

DioExceptionHandler handleError(DioError e) {
  var errorMessage = 'An unexpected error occurred. Please try again later.';

  switch (e.type) {
    case DioErrorType.sendTimeout:
      errorMessage = 'Send timeout';
      break;
    case DioErrorType.receiveTimeout:
      errorMessage = 'Receive timeout';
      break;
    case DioErrorType.cancel:
      errorMessage = 'Request was cancelled.';
      break;
    case DioErrorType.connectionTimeout:
      errorMessage = 'Connection timeout';
      break;
    case DioErrorType.badCertificate:
      errorMessage = 'Bad certificate';
      break;
    case DioErrorType.badResponse:
      errorMessage = 'Bad response';
      break;
    case DioErrorType.connectionError:
      errorMessage = 'Connection error';
      break;
    case DioErrorType.unknown:
      errorMessage = 'An unknown error occurred';
      break;
  }
  return DioExceptionHandler(errorMessage);
}
