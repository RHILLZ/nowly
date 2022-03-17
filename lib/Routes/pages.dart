import 'package:get/get.dart';
import 'package:nowly/Bindings/binding_exporter.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Auth/auth_view.dart';
import 'package:nowly/Screens/Auth/welcome_view.dart';
import 'package:nowly/Screens/Auth/start_screen_view.dart';
import 'package:nowly/Screens/Map/map_screen.dart';
import 'package:nowly/Screens/Messaging/messaging_screen.dart';
import 'package:nowly/Screens/Nav/base_screen.dart';
import 'package:nowly/Screens/Nav/home_view.dart';
import 'package:nowly/Screens/Nav/session_history_view.dart';
import 'package:nowly/Screens/OnBoarding/user_registration_view.dart';
import 'package:nowly/Screens/Account/info_screen.dart';
import 'package:nowly/Screens/Account/my_goal_screen.dart';
import 'package:nowly/Screens/Account/profile_details_screen.dart';
import 'package:nowly/Screens/Account/user_account_screen.dart';
import 'package:nowly/Screens/Sessions/current_session_en_route_details_screen.dart';
import 'package:nowly/Screens/Sessions/feedback.dart';
import 'package:nowly/Screens/Sessions/live_session_screen.dart';
import 'package:nowly/Screens/Sessions/session_complete_screen.dart';
import 'package:nowly/Screens/Sessions/session_confirmation_screen.dart';
import 'package:nowly/Screens/Sessions/session_confirmation_screen_2.dart';
import 'package:nowly/Screens/Sessions/virtual_session_view.dart';
import 'package:nowly/Screens/Stripe/add_payment_methods.dart';
import 'package:nowly/root.dart';

part 'routes.dart';

class Pages {
  Pages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.START_SCREEN;
  // ignore: constant_identifier_names
  static const ROOT = Routes.ROOT;

  static final routes = [
    GetPage(
      name: _Paths.START_SCREEN,
      page: () => StartScreenView(),
      binding: MainBinding(),
    ),
    GetPage(
        name: _Paths.AUTH_SCREEN,
        page: () => AuthView(),
        binding: MainBinding()),
    GetPage(
        name: _Paths.ROOT, page: () => const Root(), binding: MainBinding()),
    GetPage(
        name: _Paths.ONBOARDING_SCREEN,
        page: () => OnBoardingView(),
        binding: MainBinding()),
    GetPage(
        name: _Paths.BASE,
        page: () => BaseScreen(),
        binding: BaseScreenBinding()),
    GetPage(name: _Paths.HOME, page: () => UserHomeView()),
    GetPage(
        name: _Paths.MAP,
        page: () => MapScreen(),
        binding: BaseScreenBinding()),
    GetPage(name: _Paths.SESSION_HISTORY, page: () => SessionHistoryView()),
    GetPage(name: _Paths.PROFILE, page: () => const UserAccountScreen()),
    GetPage(
        binding: BaseScreenBinding(),
        name: _Paths.SESSION_CONFIRMATION,
        page: () => SessionConfirmationScreen()),
    GetPage(
        binding: BaseScreenBinding(),
        name: _Paths.SESSION_CONFIRMATION_2,
        page: () => SessionConfirmationScreen2()),
    GetPage(
        binding: BaseScreenBinding(),
        name: _Paths.SESSION_COMPLETE_SCREEN,
        page: () => SessionCompleteScreen(
            session: SessionModel(), sessionController: SessionController())),
    GetPage(
        name: _Paths.SESSION_IN_PROGRESS,
        page: () => CurrentSessionEnRouteDetailsScreen(
            session: SessionModel(),
            sessionController: Get.find<SessionController>()),
        binding: MainBinding()),
    GetPage(
        name: _Paths.LIVE_SESSION,
        page: () => LiveSessionView(
              controller: SessionController(),
            ),
        binding: BaseScreenBinding()),

    // GetPage(
    //     name: _Paths.ADD_PAYMENT_METHOD,
    //     page: () => AddPaymentMethodsScreen(),
    //     binding: BaseScreenBinding()),
    GetPage(name: _Paths.FEEDBACK_SCREEN, page: () => const FeedbackView()),
    // GetPage(
    //     name: _Paths.IN_PERSON_SESSION, page: () => const LiveSessionView()),
    GetPage(
        binding: BaseScreenBinding(),
        name: _Paths.VIRTUAL_SESSION,
        page: () =>
            VideoCallView(agoraController: Get.find<AgoraController>())),
    GetPage(
        name: _Paths.PROFILE_DETAILS, page: () => const ProfileDetailsScreen()),
    GetPage(
        name: _Paths.REGISTRATION_SCREEN,
        page: () => UserRegistrationView(),
        binding: RegistrationBinding()),

    GetPage(
        name: _Paths.GOALS_SCREEN,
        page: () => UserGoalScreen(),
        binding: BaseScreenBinding()),
    GetPage(name: _Paths.INFORMATION, page: () => UserInfoScreen()),
    GetPage(
        binding: BaseScreenBinding(),
        name: _Paths.MESSENGER_SCREEN,
        page: () => MessagingScreen(session: SessionModel())),
  ];
}
