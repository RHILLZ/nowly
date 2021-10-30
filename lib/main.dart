import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nowly/Bindings/initial_binding.dart';
import 'package:nowly/Controllers/Theme/theme_controller.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Routes/pages.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterConfig.loadEnvVariables();
  InitialBinding().dependencies();
  await initServices();
  await GetStorage.init();
  runApp(NowlyApp());
}

class NowlyApp extends StatelessWidget {
  NowlyApp({Key? key}) : super(key: key);

  final _user = Get.find<AuthController>().firebaseUser;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (ctx, _, deviceType) {
      return GetMaterialApp(
        title: 'Nowly',
        theme: Get.find<ThemeController>().getLightheme(),
        darkTheme: Get.find<ThemeController>().getDarkTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: _user != null ? Pages.ROOT : Pages.INITIAL,
        getPages: Pages.routes,
      );
    });
  }
}

initServices() async {
  await Get.putAsync(() => OneSignalService().init());
  // ignore: avoid_print
  print('All services started...');
}
