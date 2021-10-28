import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Utils/logger.dart';

class FilterController extends GetxController {
  @override
  void onReady() {
    _fecthFilterDetails();
    // _fethSessionLengths();
    _fethSessionTypes();
    super.onReady();
  }

  var isSessionTypeLoaded = false.obs;
  var isSessionLengthsLoaded = false.obs;

  final _filteredSessionMode = SessionModeModel(id: '', mode: '').obs;
  // var selectedSessionLength =
  //     SessionDurationAndCostModel(duration: '', amount: 0).obs;
  var selectedAvailability = AvailabilityModel(label: '', id: '').obs;
  var selectedSortType = SessionSortModel(label: '').obs;
  final _genderPref = TrainerPreferenceModel(type: '').obs;
  final _radius = 1.0.obs;

  set radius(value) => _radius.value = value;
  set filteredSessionMode(value) => _filteredSessionMode.value = value;
  set genderPref(value) => _genderPref.value = value;

  get radius => _radius.value;
  get filteredSessionMode => _filteredSessionMode.value;
  get genderPref => _genderPref.value;

  var sessionLengths = <SessionDurationAndCostModel>[].obs;
  var sessionModes = <SessionModeModel>[].obs;
  var avalability = <AvailabilityModel>[].obs;
  var sortTypes = <SessionSortModel>[].obs;
  var trainerTypes = <TrainerPreferenceModel>[].obs;

  // void _fethSessionLengths() {
  //   sessionLengths.addAll(SessionDurationAndCostModel.types);
  //   // selectedSessionLength.value = sessionLengths[1];
  //   isSessionLengthsLoaded.value = true;
  // }

  void _fethSessionTypes() {
    sessionModes.addAll(SessionModeModel.types);
    // selectedSessionMode.value = sessionModes[0];
    isSessionTypeLoaded.value = true;
  }

  void _fecthFilterDetails() {
    AppLogger.i('Fetching filter details');
    trainerTypes.addAll(TrainerPreferenceModel.trainerTypes);
    _genderPref.value = trainerTypes[0];
    sortTypes.addAll(SessionSortModel.sessionSorts);
    selectedSortType.value = sortTypes[0];
    avalability.addAll(AvailabilityModel.availabilities);
    selectedAvailability.value = avalability[0];
  }

  void applyFilters() => Get.back();
}
