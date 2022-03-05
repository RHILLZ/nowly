import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Controllers/Auth/preferences_controller.dart';
import 'package:nowly/Models/Firebase/xdi_user_model.dart';
import 'package:nowly/Screens/Auth/welcome_view.dart';
import 'package:nowly/Screens/Nav/base_screen.dart';
import 'package:nowly/Screens/OnBoarding/user_registration_view.dart';
import 'Controllers/controller_exporter.dart';

// class Root extends GetWidget<AuthController> {
  class Root extends GetWidget<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Get.find<AuthController>().firebaseUser;
    // final _preferences = Get.find<PreferencesController>();
    final _preferences = Get.put(PreferencesController());
    // final _userController = Get.put(UserController());
    
    if(_user != null) {
      final _isRegistered = _preferences.prefs?.getBool('register') ?? false;
      if(_isRegistered) {
        return BaseScreen();
      } else {
        return UserRegistrationView();
      }
    } 
    
    return OnBoardingView();
    // return _user != null ? BaseScreen() : OnBoardingView();
  }
}
