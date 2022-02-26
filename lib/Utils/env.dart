import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static init() async {
    await dotenv.load(fileName: 'assets/env/.env_base');
    assert(dotenv.env.containsKey("ENV"));
    final envName = dotenv.env['ENV'];
    await dotenv.load(fileName: 'assets/env/.env_$envName');

    assert(dotenv.env.containsKey("ENVIRONMENT_NAME"));
    assert(dotenv.env.containsKey("API_BASE_URL"));
  }

  static String? get environmentName => dotenv.env['ENVIRONMENT_NAME'];
  static String? get apiBaseUrl => dotenv.env['API_BASE_URL'];
  static bool get isDebug => dotenv.env['DEBUG'] == 'true';
}
