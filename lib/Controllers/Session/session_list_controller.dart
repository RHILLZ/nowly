import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Utils/logger.dart';

class SessionListController extends GetxController {
  @override
  void onReady() {
    _fetchAllTrainerSessions();
    super.onReady();
  }

  var trainersSessionControllers = <TrainerInPersonSessionController>[].obs;

  Future<void> _fetchAllTrainerSessions() async {
    AppLogger.i('Fetching trainers');
    final loadedTrainers = await TrainerInPersonSessionModel.getTrainers();
    final controllers = loadedTrainers.map((session) {
      TrainerInPersonSessionController _controller =
          Get.find(); //create new contoller for each session
      _controller.setTrainerDetails(session);
      return _controller;
    }).toList();
    MapController _mapController = Get.find();
    _mapController.addLocationDetailsToMap(controllers);
    trainersSessionControllers.addAll(controllers);
  }

  // ignore: unused_element
  Future<void> _applyFilters() async {
    await TrainerInPersonSessionModel.getTrainers();
  }
}
