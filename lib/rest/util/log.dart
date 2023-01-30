import 'package:logger/logger.dart';


class Log {
  static final Logger _instance = Logger(
    filter: null,
    printer: PrettyPrinter(),
    output: null,
  );

  static Logger get instance => _instance;
}
