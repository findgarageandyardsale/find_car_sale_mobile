import 'package:flutter/foundation.dart';
import 'dart:async';

///Debouncer class for search feature
class CustomDebouncer {
  final int milliseconds;
  Timer? _timer;

  CustomDebouncer({this.milliseconds = 1000});

  ///checks the timer with durations
  run(VoidCallback action) {
    if (_timer != null || (_timer?.isActive ?? false)) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
