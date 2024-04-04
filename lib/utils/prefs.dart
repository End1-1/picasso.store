import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension Prefs on SharedPreferences {
  static final navigatorKey = GlobalKey<NavigatorState>();

  String apiKey() {
    return string('apikey');
  }

  BuildContext context() {
    return navigatorKey.currentContext!;
  }

  String string(String key) {
    return getString(key) ?? '';
  }
}

late final SharedPreferences prefs;
