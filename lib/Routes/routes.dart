// ignore_for_file: constant_identifier_names

part of 'pages.dart';

abstract class Routes {
  Routes._();
  static const START_SCREEN = _Paths.START_SCREEN;
  static const ONBOARDING_SCREEN = _Paths.ONBOARDING_SCREEN;
  static const AUTH_SCREEN = _Paths.AUTH_SCREEN;
  static const ROOT = _Paths.ROOT;
  static const BASE = _Paths.BASE;
  static const HOME = _Paths.HOME;
  static const MAP = _Paths.MAP;
  static const SESSION_HISTORY = _Paths.SESSION_HISTORY;
  static const PROFILE = _Paths.PROFILE;
  static const SESSION_CONFIRMATION = _Paths.SESSION_CONFIRMATION;
  static const SESSION_COMPLETE_SCREEN = _Paths.SESSION_COMPLETE_SCREEN;
  static const SESSION_IN_PROGRESS = _Paths.SESSION_IN_PROGRESS;
  // static const CURRENT_SESSION_DETAILS = _Paths.CURRENT_SESSION_DETAILS;
  static const LIVE_SESSION = _Paths.LIVE_SESSION;
  static const VIRTUAL_SESSION = _Paths.VIRTUAL_SESSION;
  static const IN_PERSON_SESSION = _Paths.IN_PERSON_SESSION;
  static const FUTURE_SESSION_CONFIRMATION = _Paths.FUTURE_SESSION_CONFIRMATION;
  static const LOCATION_SELECTION = _Paths.LOCATION_SELECTION;
  static const FEEDBACK_SCREEN = _Paths.FEEDBACK_SCREEN;
  static const REGISTRATION_SCREEN = _Paths.REGISTRATION_SCREEN;
  static const ADD_PAYMENT_METHOD = _Paths.ADD_PAYMENT_METHOD;
  static const PROFILE_DETAILS = _Paths.PROFILE_DETAILS;
  static const INFORMATION = _Paths.INFORMATION;
  static const GOALS_SCREEN = _Paths.GOALS_SCREEN;
  static const MESSENGER_SCREEN = _Paths.MESSENGER_SCREEN;
}

abstract class _Paths {
  static const START_SCREEN = '/start_screen';
  static const ONBOARDING_SCREEN = '/onboarding';
  static const AUTH_SCREEN = '/auth';
  static const ROOT = '/root';
  static const BASE = '/base';
  static const HOME = '/home';
  static const MAP = '/map';
  static const SESSION_HISTORY = '/session_history';
  static const PROFILE = '/profile';
  static const SESSION_CONFIRMATION = '/session_confirmation';
  static const SESSION_CONFIRMATION_2 = '/session_confirmation_2';
  static const SESSION_COMPLETE_SCREEN = '/session_complete';
  static const SESSION_IN_PROGRESS = '/currentSession';
  // static const CURRENT_SESSION_DETAILS = '//currentSession';
  static const LIVE_SESSION = '/live_session';
  static const VIRTUAL_SESSION = '/virtual_session';
  static const IN_PERSON_SESSION = '/in_person_session';
  static const FUTURE_SESSION_CONFIRMATION = '/future_session_confirmation';
  static const LOCATION_SELECTION = '/location_selection';
  static const FEEDBACK_SCREEN = '/feedback_screen';
  static const REGISTRATION_SCREEN = '/registration';
  static const ADD_PAYMENT_METHOD = '/add_payment_method';
  static const PROFILE_DETAILS = '/profile_details';
  static const INFORMATION = '/information;';
  static const GOALS_SCREEN = '/goals';
  static const MESSENGER_SCREEN = '/messagingScreen';
}
