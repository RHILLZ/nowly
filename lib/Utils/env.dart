import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static init() async {
    await dotenv.load(fileName: '.env');
    assert(dotenv.env.containsKey("ENV"));
    final envName = dotenv.env['ENV'];
    await dotenv.load(fileName: '.env.$envName');

    assert(dotenv.env.containsKey("ENVIRONMENT_NAME"));
    assert(dotenv.env.containsKey("API_BASE_URL"));
  }

  static String? get environmentName => dotenv.env['ENVIRONMENT_NAME'];
  static String? get apiBaseUrl => dotenv.env['API_BASE_URL'];
  static String? get agoraId => dotenv.env['AGORA_ID'];
  static String? get androidMapsKey => dotenv.env['ANDROID_MAPS_KEY'];
  static String? get iosMapsKey => dotenv.env['IOS_MAPS_KEY'];
  static String? get mixPanelToken => dotenv.env['MIXPANEL_TOKEN'];
  static bool get isDebug => dotenv.env['DEBUG'] == 'true';
  static String? get agoraId => dotenv.env['AGORA_ID'];
  static String? get androidMapsKey => dotenv.env['ANDROID_MAPS_KEY'];
  static String? get iosMapsKey => dotenv.env['IOS_MAPS_KEY'];
  static String? get mixPanelToken => dotenv.env['MIXPANEL_TOKEN'];
}
