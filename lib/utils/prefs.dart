import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Prefs on SharedPreferences {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final mdDoubleFormatter = NumberFormat.decimalPattern('en_us');
  static final regex = RegExp(r"([.]*0+)(?!.*\d)");
  static Map<String, dynamic> config = {};
  static final List<String> debugInfo = [];
  static bool debugMode = false;

  BuildContext context() {
    return navigatorKey.currentContext!;
  }

  String string(String key) {
    return getString(key) ?? '';
  }

  String df(String v) {
    return v.replaceAll(RegExp('r(?!\d[\.\,][1-9]+)0+\$'), '').replaceAll('[\.\,]\$', '');
  }

  String currentDateText() {
    DateTime dt = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  DateTime strDate(String s) {
    return DateFormat('yyyy-MM-dd').tryParse(s) ?? DateTime.now();
  }

  String dateText(DateTime dt) {
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  String dateMySqlText(DateTime dt) {
    return DateFormat('yyyy-MM-dd').format(dt);
  }

  DateTime workingDay() {
    return strDate(string('workingday'));
  }

  String number(num v) {
    var nf = NumberFormat.decimalPatternDigits(locale: 'en_us',
      decimalDigits:0);
    return nf.format(v);
  }

  String mdFormatDouble(num? value) {
    if (value == null) return '0';
    final str = mdDoubleFormatter.format(value);


    final parts = str.split('.');

    if (parts.length == 2) {
      if (RegExp(r'^0+$').hasMatch(parts[1])) {
        return parts[0];
      } else {
        final fractional = parts[1].replaceFirst(RegExp(r'0+$'), '');
        return '${parts[0]}.$fractional';
      }
    }

    return str;
  }

  void init() {
    config.clear();

    var configString = string('config');
    print(configString);
    if (configString.isEmpty) {
      configString = '{}';
    }
    try {
      config = jsonDecode(configString);
      debugMode = config['debug_mode'] ?? false;
    } catch (e) {
      setString('config', '{}');
      config = {'dashboard': ''};
    }
  }
}

late final SharedPreferences prefs;

AppLocalizations locale() {
  return AppLocalizations.of(prefs.context())!;
}

void debugInfo(dynamic m) {
  if (kDebugMode) {
    print(m);
  }
  if (Prefs.debugMode) {
    Prefs.debugInfo.add(m.toString());
  }
}