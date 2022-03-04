import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Screens/Auth/welcome_view.dart';
import 'package:nowly/Screens/Nav/base_screen.dart';

import 'Controllers/controller_exporter.dart';

class Root extends GetWidget<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Get.find<AuthController>().firebaseUser;
    return _user != null ? BaseScreen() : OnBoardingView();
  }
}
