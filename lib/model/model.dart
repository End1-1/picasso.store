import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/screen/dashboard.dart';
import 'package:cafe5_mworker/screen/login.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WMModel {
  final serverTextController = TextEditingController();
  final serverUserTextController = TextEditingController();
  final serverPasswordTextController = TextEditingController();
  final configPinTextController = TextEditingController();

  WMModel();

  String tr(String s) {
    return s;
  }

  void registerOnServer() {
    prefs.setString('serveraddress', serverTextController.text);
    BlocProvider.of<AppBloc>(Prefs.navigatorKey.currentContext!).add(
        AppEventLoading(
            tr('Registering on server'), 'engine/register-on-server.php', {
      'username': serverUserTextController.text,
      'password': serverPasswordTextController.text
    }, (e, d) {
      if (!e) {
        prefs.setString('serveraddress', serverTextController.text);
        prefs.setString('apikey', d['apikey']);
        serverPasswordTextController.clear();
        serverUserTextController.clear();
        Navigator.pop(prefs.context());
      }
    }));
  }

  void loginUsernamePassword() {
    BlocProvider.of<AppBloc>(prefs.context())
        .add(AppEventLoading(tr('Sign in'), 'engine/login.php', {
      "username": serverUserTextController.text,
      "password": serverPasswordTextController.text,
      "method": WMLogin.username_password
    }, (e, d) {
      if (!e) {
        prefs.setString('sessionkey', d['sessionkey']);
        Navigator.pushAndRemoveUntil(
            prefs.context(),
            MaterialPageRoute(builder: (builder) => WMDashboard(model: this)),
            (route) => false);
      }
    }));
  }

  void loginPin() {}

  void loginPasswordHash() {
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        tr('Sign in'), 'engine/login.php', {
      'sessionkey': prefs.string('sessionkey'),
      'method': WMLogin.password_hash
    }, (e, d) {
      if (e) {
        prefs.setBool('stayloggedin', false);
        prefs.setString('sessionkey', '');
      } else {
        Navigator.pushAndRemoveUntil(
            prefs.context(),
            MaterialPageRoute(builder: (builder) => WMDashboard(model: this)),
            (route) => false);
      }
    }));
  }

  void closeDialog() {
    BlocProvider.of<AppBloc>(Prefs.navigatorKey.currentContext!)
        .add(AppEvent());
  }
}
