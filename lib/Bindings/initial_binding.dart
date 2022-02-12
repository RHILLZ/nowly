import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController());
  }
}
