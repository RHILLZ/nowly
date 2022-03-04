import 'dart:async';

import 'package:get/get.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// welcome_view controller
class PreferencesController extends GetxController {
  /// Populate variables from cache
  // PreferencesController(SharedPreferences prefs) {
  //   _prefs = prefs;
  //   AppLogger.i('SharedPreferences initialised');
  // }
  var _prefs = Rxn<SharedPreferences>();
  final _onboarding = RxString('');


  @override
  Future<void> onInit() async {
    _prefs = Rxn(await SharedPreferences.getInstance());
    super.onInit();
  }

  // get prefs => _prefs;
  // set onboarding(value) {
  //   _onboarding.value = value;
  //   _prefs.setString('onboardSelection', value);
  // }

  get onboarding => _onboarding.value;

  set setOnboarding(value) {
    _prefs?.value.setString('onboardSelection', value);
  }

  Future<void> setStringPref(String key, String value) async => _prefs?.value.setString(key, value);

  Future<void> setBoolPref(String key, bool value) async => _prefs?.value.setBool(key, value);

  bool? getBoolPref(String key) => _prefs?.value.getBool(key);

  String? getStringPref(String key) => _prefs?.value.getString(key);

  // /// returns the onboarding value
  // String get onboarding => _onboarding.value;
}
