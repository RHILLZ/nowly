import 'package:get/get.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsController extends GetxController {
  late SharedPreferences _prefs;

  @override
  void onInit() async {
    // TODO: implement onInit
    await init();
    super.onInit();
  }

  get prefs => _prefs;

  Future<void> init() async{
    _prefs = await SharedPreferences.getInstance();
    AppLogger.i('Preferences Initialised');
  }
}