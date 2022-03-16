import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_phoenix/generated/i18n.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:nowly/Bindings/binding_exporter.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Routes/pages.dart';
import 'package:nowly/Utils/util_exporter.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.init();
  
  Stripe.publishableKey = Env.publishKey;
  await Stripe.instance.applySettings();

  await Firebase.initializeApp();

  MainBinding().dependencies();

  await _setupNotifications();
  await _setupFirebaseCrashlytics();
  // await Stripe.instance.applySettings();

  runApp(Phoenix(child: const NowlyApp()));
}

/// Sets up the remote and local notifications channels and listeners.
Future<void> _setupNotifications() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon.png',
    [
      NotificationChannel(
        channelKey: 'normal',
        channelName: 'normal',
        enableVibration: true,
        channelShowBadge: false,
        importance: NotificationImportance.Default,
        onlyAlertOnce: true,
        defaultColor: kPrimaryColor,
        channelDescription: 'All Notifications',
      ),
    ],
  );

  FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
}

Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
  await AwesomeNotifications().createNotificationFromJsonData(message.data);
  AppLogger.info(message.data);
}

/// Configures Firebase Crashlytics to receive uncaught [Exception]s and
/// [Error]s from the framework to Crashlytics.
Future<void> _setupFirebaseCrashlytics() async {
  final firebaseCrashlytics = Get.find<FirebaseCrashlytics>();

  await firebaseCrashlytics.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = firebaseCrashlytics.recordFlutterError;
}

/// {@template NowlyApp}
/// The app's root widget.
/// {@endtemplate}
class NowlyApp extends StatelessWidget {
  /// {@macro NowlyApp}
  const NowlyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authController = Get.put(AuthController());

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
