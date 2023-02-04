import 'package:logger/logger.dart';

// Log class to provide a singleton instance of the logger
// In production mode, the logger will be disabled

class Log {
  static final Logger _instance = Logger(
    filter: null,
    printer: PrettyPrinter(),
    output: null,
  );

  static Logger get instance => _instance;
}
