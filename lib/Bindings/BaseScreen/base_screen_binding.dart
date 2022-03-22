import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

class BaseScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => SessionController(), permanent: true);
    Get.put(() => StripeController());

    // for map screen
    Get.lazyPut(() => FilterController());

    Get.lazyPut(() => AgoraController());
    Get.put(() => UserController());
    Get.lazyPut(() => MessagingController());
  }
}
