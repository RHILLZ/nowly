import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesController extends GetxController {
  final _prefs = Rxn<SharedPreferences>();  

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    _prefs.value = await SharedPreferences.getInstance();
    super.onInit();
  }

  SharedPreferences? get prefs => _prefs.value;
}
