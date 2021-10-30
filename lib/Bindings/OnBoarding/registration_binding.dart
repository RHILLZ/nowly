import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(() => RegistrationController());
  }
}
