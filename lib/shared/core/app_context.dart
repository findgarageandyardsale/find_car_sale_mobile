import 'package:flutter/material.dart';

class AppContext {
  static BuildContext? _appContext;
  static AppContext? _instance;

  factory AppContext() {
    _instance ??= AppContext._();
    return _instance ?? AppContext._();
  }

  AppContext._();

  static void setContext(BuildContext context) {
    _appContext = context;
  }

  BuildContext? getContext() {
    return _appContext;
  }
}
