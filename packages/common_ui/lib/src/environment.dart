class EnvironmentFlavor {
  static const String? appEnv = String.fromEnvironment('APP_ENV');

  static bool get isProduction => appEnv?.toLowerCase() == 'production';

  static bool get isStaging => appEnv?.toLowerCase() == 'staging';

  static bool get isDev => appEnv?.toLowerCase() == 'development';
}
