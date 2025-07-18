enum AppEnv {
  development,
  staging,
  production,
}

extension AppEnvExtension on AppEnv {
  String get name {
    switch (this) {
      case AppEnv.development:
        return 'Development';
      case AppEnv.staging:
        return 'Staging';
      case AppEnv.production:
        return 'Production';
    }
  }
  
  bool get isDevelopment => this == AppEnv.development;
  bool get isStaging => this == AppEnv.staging;
  bool get isProduction => this == AppEnv.production;
}