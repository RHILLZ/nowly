import 'package:logger/logger.dart';

class AppLogger {
  static final _logger = Logger(printer: PrettyPrinter(lineLength: 200));

  static void i(dynamic message) {
    _logger.i(message);
  }

  static void d(dynamic message) {
    _logger.d(message);
  }

  static void w(dynamic message) {
    _logger.w(message);
  }


  static void e(dynamic message) {
    _logger.e(message);
  }

  static void wtf(dynamic message) {
    _logger.wtf(message);
  }
}
