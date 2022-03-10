import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';

/// Logs message in the debug console and sends error logs to the
/// [FirebaseCrashlytics].
class AppLogger {
  /// Logs a message at level [Level.info].
  static void info(dynamic message) => Get.find<Logger>().i(message);

  /// Logs a message at level [Level.debug].
  static void debug(dynamic message) => Get.find<Logger>().d(message);

  /// Logs a message at level [Level.warning].
  static void warning(dynamic message) => Get.find<Logger>().w(message);

  /// Logs a message at level [Level.error] then sends the [error] and
  /// [stackTrace] to [FirebaseCrashlytics].
  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    Get.find<FirebaseCrashlytics>().recordError(error, stackTrace);
    Get.find<Logger>().e(message, error, stackTrace);
  }
}
