import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

class BaseScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SessionController());
    Get.lazyPut(() => StripeController());

    //for map screen
    Get.lazyPut(() => SessionListController());
    Get.create(() => TrainerInPersonSessionController());
    Get.lazyPut(() => MapController());
    Get.lazyPut(() => SessionScheduleController());
    Get.lazyPut(() => FilterController());

    // Get.lazyPut(() => AgoraController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => MapNavigatorController());
  }
}
