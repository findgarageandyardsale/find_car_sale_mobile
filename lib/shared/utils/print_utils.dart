import 'dart:developer';

import 'package:flutter/foundation.dart';

class PrintUtils {
  static void customLog(String message) {
    if (kDebugMode) log(message);
  }

  static bool radiusInAllChip = true;
}
