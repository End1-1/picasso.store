import 'package:cafe5_mworker/model/model.dart';
import 'package:cafe5_mworker/screen/config.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:flutter/material.dart';

class Navigation {
  final WMModel model;

  Navigation(this.model);

  Future<void> config() {
    return Navigator.push(Prefs.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (builder) => WMConfig(model: model)));
  }
}
