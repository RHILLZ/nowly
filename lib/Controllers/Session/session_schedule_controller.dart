import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';

class SessionScheduleController extends GetxController {
  Rx<SessionScheduleModel> selectedDateDetail = SessionScheduleModel().obs;

  final focusedDay = DateTime.now().obs;
  final selectedDay = DateTime.now().obs;

  void changeTime({required DateTime? time}) {
    selectedDateDetail.update((val) {
      val!.selectedTime = time;
    });
  }

  void changeDate({required DateTime date}) {
    selectedDateDetail.update((val) {
      val!.selectedDate = date;
    });
  }
}
