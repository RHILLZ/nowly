import 'package:get/get.dart';
import 'package:nowly/Controllers/shared_preferences/preferences_controller.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Services/Stripe/android_stripe_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(PreferencesController());
    Get.put(AuthController());
    Get.put(AndroidStripeController());
  }
}
