import 'package:waaiburg_app/environment/environmentConfig.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  // static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      // case Environment.STAGING:
      //   return StagingConfig();
      default:
        return DevConfig();
    }
  }
}

