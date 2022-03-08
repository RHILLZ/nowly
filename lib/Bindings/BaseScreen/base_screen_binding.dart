import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

class BaseScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => SessionController(), permanent: true);
    Get.put(() => StripeController());

    // for map screen
    Get.put(() => SessionListController());
    Get.create(() => TrainerInPersonSessionController());
    Get.put(() => MapController());
    Get.lazyPut(() => FilterController());

    Get.lazyPut(() => AgoraController());
    Get.put(() => UserController());
    Get.put(() => MapNavigatorController());
    Get.lazyPut(() => MessagingController());
  }
}
