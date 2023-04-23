import 'package:Array_App/rest/util/logger/base_logger.dart';
import 'package:logger/logger.dart';

/// This class is a wrapper for the [Logger] package.
class CustomLogger extends BaseLogger {
  CustomLogger(this._logger);

  final Logger _logger;

  @override
  void i(String message) => _logger.i(message);

  @override
  void d(String message) => _logger.d(message);

  @override
  void e(String message) => _logger.e(message);

  @override
  void w(String message) => _logger.w(message);

  @override
  void v(String message) => _logger.v(message);

  @override
  void wtf(String message) => _logger.wtf(message);
}
