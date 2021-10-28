import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/Firebase/firebase_futures.dart';
import 'package:nowly/Services/Firebase/firebase_streams.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'controller_exporter.dart';

class UserController extends GetxController {
  final Rx<UserModel> _user = UserModel().obs;
  final _myWeight = ''.obs;
  RxList<SessionReceiptModel> sessionReceipts = <SessionReceiptModel>[].obs;
  RxList<SessionModel> scheduledSessions = <SessionModel>[].obs;
  final visibleAppointIndex = 0.obs;

  //FROM MYFITNESSGOALSCONTROLLER
  final _allFitnessGoals = <FitnessGoals>[].obs;
  final _myFavoriteWorkouts = <WorkoutType>[].obs;

  get user => _user.value;
  get allFitnessGoals => _allFitnessGoals;
  get myFavoriteWorkouts => _myFavoriteWorkouts;

  set myWeight(value) => _myWeight.value = value;

  @override
  void onInit() async {
    super.onInit();
    final uid = Get.put(AuthController()).firebaseUser.uid;
    _user.bindStream(FirebaseStreams().streamUser(uid));
    _getAllFitnessGoals();
    Future.delayed(const Duration(seconds: 2), () => checkOneSignalId());
    Get.put(SessionController()).user = _user.value;
    sessionReceipts.value = await FirebaseFutures().getSessionReceipts(uid);
    scheduledSessions.bindStream(FirebaseStreams().streamUserAppointments(uid));
  }

// CHECK FOR ONESIGNAL ID AND SET IF NONE FOUND
  checkOneSignalId() async {
    final currentOneSignalId = _user.value.oneSignalId ?? '';
    final oneSignalId =
        await OneSignal.shared.getDeviceState().then((value) => value!.userId);
    if (currentOneSignalId != oneSignalId) {
      FirebaseFutures().setUserOneSignalId(_user.value.id!, oneSignalId!);
    }
  }

  //GET FITNESS GOALS
  _getAllFitnessGoals() => _allFitnessGoals.addAll(FitnessGoals.fitnessGoals);
}
