import 'package:get/get.dart';
import 'package:nowly/Controllers/OnBoarding/preferences_controller.dart';
import 'package:nowly/Controllers/OnBoarding/prefs_controller.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(ThemeController());
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // PreferencesController _controller = P?referencesController();
    // _controller.pref = _prefs;
    Get.put(PrefsController());
    Get.put(PreferencesController());
    // Get.put(AuthController());
  }
}
