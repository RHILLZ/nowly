import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nowly/Bindings/binding_exporter.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Routes/pages.dart';
import 'package:sizer/sizer.dart';

import 'Configs/configs.dart';
import 'Utils/env.dart';
import 'Utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
  await GetStorage.init();
  // final _pref = await SharedPreferences.getInstance();
  // Get.put(_pref);
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

    return Sizer(
      builder: (ctx, _, deviceType) {
        return GetMaterialApp(
          title: 'Nowly',
          theme: Get.find<ThemeController>().getLightheme(),
          darkTheme: Get.find<ThemeController>().getDarkTheme(),
          getPages: Pages.routes,
          debugShowCheckedModeBanner: false,
          initialRoute:
              _authController.firebaseUser != null ? Pages.ROOT : Pages.INITIAL,
          initialBinding: BaseScreenBinding(),
          builder: (context, child) => _FlavorBuildModeBanner(child: child!),
        );
      },
    );
  }
}

/// A banner shown at the top-right side of the page which displays what flavor
/// and build was used to run the application.
///
/// If the app flavor is [Flavor.prod] and the build mode is
/// [BuildMode.release], then the banner will not be displayed.
class _FlavorBuildModeBanner extends StatelessWidget {
  const _FlavorBuildModeBanner({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final flavor = Env.flavor;
    final buildMode = Env.buildMode;

    if (flavor == Flavor.prod && buildMode == BuildMode.release) {
      return child;
    }

    return Banner(
      message: '${flavor.name}-${buildMode.name}',
      location: BannerLocation.topEnd,
      child: child,
    );
  }
}
