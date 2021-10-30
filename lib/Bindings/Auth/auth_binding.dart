import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
