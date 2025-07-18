import 'package:flutter/foundation.dart';
import 'package:gem_speak/common/constant/environment_variables.dart';
import 'package:logger/logger.dart';

class AppLogFilters extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (EnvironmentVariables.verbose) {
      return true;
    } else if (kReleaseMode) {
      return event.level.index >= Level.warning.index;
    } else {
      return true;
    }
  }
}