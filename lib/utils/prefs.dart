import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension Prefs on SharedPreferences {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final regex = RegExp(r"([.]*0+)(?!.*\d)");
  static Map<String, dynamic> config = {};

  BuildContext context() {
    return navigatorKey.currentContext!;
  }

  String string(String key) {
    return getString(key) ?? '';
  }

  String df(String v) {
    return v.replaceAll(Prefs.regex, '');
  }

  String currentDateText() {
    DateTime dt = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  DateTime strDate(String s) {
    return DateFormat('yyyy-MM-dd').parse(s);
  }

  String dateText(DateTime dt) {
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  String dateMySqlText(DateTime dt) {
    return DateFormat('yyyy-MM-dd').format(dt);
  }

  void init() {
    config.clear();

    var configString = string('config');
    if (configString.isEmpty) {
      configString = '{}';
    }
    config = jsonDecode(configString);
  }
}

late final SharedPreferences prefs;
