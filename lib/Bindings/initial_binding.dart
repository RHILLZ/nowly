import 'package:get/get.dart';
import 'package:nowly/Controllers/Auth/preferences_controller.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController());
    Get.put(PreferencesController());
  }
}
