import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static init() async {
    const envName = String.fromEnvironment('ENV');
    await dotenv.load(fileName: 'env/.env.$envName');

    assert(dotenv.env.containsKey("API_BASE_URL"));
  }

  static String? get environmentName => String.fromEnvironment('ENV');
  static String? get apiBaseUrl => dotenv.env['API_BASE_URL'];
  static String? get agoraId => dotenv.env['AGORA_ID'];
  static String? get androidMapsKey => dotenv.env['ANDROID_MAPS_KEY'];
  static String? get iosMapsKey => dotenv.env['IOS_MAPS_KEY'];
  static String? get mixPanelToken => dotenv.env['MIXPANEL_TOKEN'];
  static bool get isDebug => dotenv.env['DEBUG'] == 'true';
}

// debug
// 