import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nowly/Bindings/binding_exporter.dart';
import 'package:nowly/Bindings/initial_binding.dart';
import 'package:nowly/Controllers/Theme/theme_controller.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Routes/pages.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:sizer/sizer.dart';

import 'Configs/configs.dart';
import 'Utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
  await GetStorage.init();
  InitialBinding().dependencies();
  AwesomeNotifications()
      .initialize('resource://drawable/res_notification_app_icon.png', [
    NotificationChannel(
        channelKey: 'normal',
        channelName: 'normal',
        enableVibration: true,
        channelShowBadge: false,
        importance: NotificationImportance.Default,
        onlyAlertOnce: true,
        defaultColor: kPrimaryColor,
        channelDescription: 'All Notifications'),
  ]);

  runApp(Phoenix(child: const NowlyApp()));
}

Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AppLogger.i(message.data);
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

class NowlyApp extends StatelessWidget {
  const NowlyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(AuthController());

    return Sizer(builder: (ctx, _, deviceType) {
      return GetMaterialApp(
        title: 'Nowly',
        theme: Get.find<ThemeController>().getLightheme(),
        darkTheme: Get.find<ThemeController>().getDarkTheme(),
        debugShowCheckedModeBanner: false,
        getPages: Pages.routes,
        initialRoute:
            _authController.firebaseUser != null ? Pages.ROOT : Pages.INITIAL,
        initialBinding: BaseScreenBinding(),
      );
    });
  }
}
