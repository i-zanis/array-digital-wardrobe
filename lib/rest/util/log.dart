import 'package:logger/logger.dart';

// Log class to provide a singleton instance of the logger
// In production mode, the logger will be disabled

class Log {
  static SimplePrinter simplePrinter = SimplePrinter(colors: true);

  static final Logger _instance = Logger(
    filter: null,
    printer: simplePrinter,
    output: null,
    // level: Level.info,
  );

  final prettyPrinter = PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 0,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: false,
  );
  static Logger get instance => _instance;
}
