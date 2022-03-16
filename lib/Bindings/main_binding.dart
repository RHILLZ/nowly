import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nowly/Services/Stripe/fstripe_services.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Controllers/shared_preferences/preferences_controller.dart';

/// The main dependency injection container loaded when the app is started.
class MainBinding implements Bindings {
  @override
  void dependencies() {
    _injectDependencies();
    _injectControllers();
  }

  /// Injects all external dependencies.
  void _injectDependencies() {
    Get
      ..lazyPut<FirebaseCrashlytics>(
        () => FirebaseCrashlytics.instance,
        fenix: true,
      )
      ..lazyPut<Logger>(
        () => Logger(printer: PrettyPrinter(lineLength: 200)),
        fenix: true,
      );
  }

  /// Injects all [GetxController].
  void _injectControllers() {
    Get
      ..put(AuthController())
      ..put(PreferencesController())
      ..put(ThemeController());
  }
}
