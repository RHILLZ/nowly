import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Screens/Auth/auth_view.dart';
import 'package:nowly/Screens/Nav/base_screen.dart';

import 'Controllers/controller_exporter.dart';

class Root extends GetWidget<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
        init: AuthController(),
        builder: (_) {
          if (_.firebaseUser != null) {
            return BaseScreen();
          } else {
            return AuthView();
          }
        });
  }
}
