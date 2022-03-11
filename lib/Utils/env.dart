import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const androidStripePublishableKey = "pk_test_51JXoZrHxTvaJqgJRAreTvzeLTmp9xUDkgYRY4K0yZA8JcE4faFmRUvjBBPmgkCWjyBI1DiQ3FIaJBg0sCtFSA0q6009d90fyqv";

/// The available flavors for the application.
enum Flavor {
  /// The identifier for the development flavor.
  dev,

  /// The identifier for the test flavor.
  test,

  /// The identifier for the production flavor.
  prod,
}

/// The available build modes for the application.
enum BuildMode {
  /// The identifier for the debug build.
  debug,

  /// The identifier for the profile build.
  profile,

  /// The identifier for the release build.
  release,
}

/// {@template Env}
/// A class for accessing environment variables.
/// {@endtemplate}
class Env {
  /// {@macro Env}
  const Env._();

  /// Loads the appropriate environment variables based on the current app
  /// flavor.
  static Future<void> init() async {
    const envName = String.fromEnvironment('ENV');
    await dotenv.load(fileName: 'env/.env.$envName');
  }

  /// Returns the flavor used to run the app.
  static Flavor get flavor {
    const flavorStr = String.fromEnvironment('ENV');

    switch (flavorStr) {
      case 'dev':
        return Flavor.dev;
      case 'test':
        return Flavor.test;
      case 'prod':
        return Flavor.prod;
    }

    throw UnsupportedError('The flavor $flavorStr is not supported');
  }

  /// Returns the build mode used to run the app.
  static BuildMode get buildMode => kDebugMode
      ? BuildMode.debug
      : kProfileMode
          ? BuildMode.profile
          : BuildMode.release;

  static String get apiBaseUrl => _nonNullEnvironment('API_BASE_URL');
  static String get agoraId => _nonNullEnvironment('AGORA_ID');
  static String get androidMapsKey => _nonNullEnvironment('ANDROID_MAPS_KEY');
  static String get iosMapsKey => _nonNullEnvironment('IOS_MAPS_KEY');

  static String? get mixPanelToken => dotenv.env['MIXPANEL_TOKEN'];

  static String get androidStripePublishKey => 
    _nonNullEnvironment('ANDROID_STRIPE_PUBLISH_KEY');

  /// Ensures that an environment variable returns value. Otherwise, a
  /// [UnimplementedError] will be thrown.
  static String _nonNullEnvironment(String key) {
    final value = dotenv.env[key];

    if (value == null) {
      throw UnimplementedError(
          'Environment variable $key does not have a value');
    }

    return value;
  }
}
