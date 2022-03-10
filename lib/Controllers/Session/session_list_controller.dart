import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/Firebase/firebase_streams.dart';
import 'package:nowly/Utils/app_logger.dart';

class SessionListController extends GetxController {
  final onlineTrainers = <TrainerInPersonSessionModel>[].obs;

  @override
  void onInit() {
    // ignore: todo
    super.onInit();
    ever(onlineTrainers, (callback) => _fetchAllOnlineTrainers());
    onlineTrainers.bindStream(FirebaseStreams().streamOnlineTrainers(
        SessionDurationAndCostModel.inPersonSessionOptions));
  }

  @override
  void onReady() {
    _fetchAllOnlineTrainers();
    super.onReady();
  }

  var trainersSessionControllers = <TrainerInPersonSessionController>[].obs;

  Future<void> _fetchAllOnlineTrainers() async {
    AppLogger.info('Fetching trainers');
    final loadedTrainers = onlineTrainers;
    AppLogger.info('TRAINERS: $onlineTrainers');
    final controllers = loadedTrainers.map((session) {
      TrainerInPersonSessionController _controller = Get.put(
          TrainerInPersonSessionController()); //create new contoller for each session
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
