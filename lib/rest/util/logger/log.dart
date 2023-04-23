import 'package:Array_App/rest/util/logger/base_logger.dart';
import 'package:logger/logger.dart';

import 'custom_logger.dart';

/// This class is a singleton that provides a logger instance to the whole app.
class Log {
  Log._(this._baseLogger);

  static SimplePrinter simplePrinter = SimplePrinter(colors: true);

  static final Logger _logger = Logger(
    filter: null,
    printer: simplePrinter,
    output: null,
  );

  static final Log _instance = Log._(CustomLogger(_logger));

  final BaseLogger _baseLogger;

  static BaseLogger get instance => _instance._baseLogger;
}
