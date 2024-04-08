import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension Prefs on SharedPreferences {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final regex = RegExp(r"([.]*0+)(?!.*\d)");

  String apiKey() {
    return string('apikey');
  }

  BuildContext context() {
    return navigatorKey.currentContext!;
  }

  String string(String key) {
    return getString(key) ?? '';
  }

  String df(String v){
    return v.replaceAll(Prefs.regex, '');
  }

  String currentDateText() {
    DateTime dt = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  String dateText(DateTime dt) {
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  String dateMySqlText(DateTime dt) {
    return DateFormat('yyyy-MM-dd').format(dt);
  }
}

late final SharedPreferences prefs;
