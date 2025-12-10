import 'dart:developer' show log;

import 'package:flutter/foundation.dart' show kDebugMode;

void avoidPrint(dynamic message) {
  if (kDebugMode) {
    print(message.toString());
  }
}

void avoidLog(dynamic message) {
  if (kDebugMode) {
    log(message.toString());
  }
}
