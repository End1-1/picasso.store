import 'dart:convert';

import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/bloc/question_bloc.dart';
import 'package:cafe5_mworker/screen/dashboard.dart';
import 'package:cafe5_mworker/screen/login.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation.dart';

class AppStateAppBar extends AppState {}

class AppEventAppBar extends AppEvent {}

class WMModel {
  final serverTextController = TextEditingController();
  final serverUserTextController = TextEditingController();
  final serverPasswordTextController = TextEditingController();
  final configPinTextController = TextEditingController();

  late final Navigation navigation;

  WMModel() {
    navigation = Navigation(this);
  }

  String tr(String s) {
    return Res.tr[s] ?? s;
  }

  void registerOnServer() {
    prefs.setString('serveraddress', serverTextController.text);
    BlocProvider.of<AppBloc>(Prefs.navigatorKey.currentContext!)
        .add(AppEventLoading(tr('Registering on server'), 'engine/login.php', {
      'method': 1,
      'username': serverUserTextController.text,
      'password': serverPasswordTextController.text
    }, (e, d) {
      if (!e) {
        prefs.setString('serveraddress', serverTextController.text);
        serverPasswordTextController.clear();
        serverUserTextController.clear();
        Navigator.pop(prefs.context(), true);
      }
    }, AppStateFinished(data: null)));
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
        prefs.setString('config', jsonEncode(d['config']['f_config']));
        prefs.init();
        Navigator.pushAndRemoveUntil(
            prefs.context(),
            MaterialPageRoute(builder: (builder) => WMDashboard(model: this)),
            (route) => false);
      }
    }, AppStateFinished(data: null)));
  }

  void passwordSubmitted(String s) {
    loginUsernamePassword();
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
        prefs.setString('config', d['config']['f_config']);
        prefs.init();
        Navigator.pushAndRemoveUntil(
            prefs.context(),
            MaterialPageRoute(builder: (builder) => WMDashboard(model: this)),
            (route) => false);
      }
    }, AppStateFinished(data: null)));
  }

  void closeDialog() {
    BlocProvider.of<AppBloc>(Prefs.navigatorKey.currentContext!)
        .add(AppEvent());
  }

  void closeQuestionDialog() {
    BlocProvider.of<QuestionBloc>(Prefs.navigatorKey.currentContext!)
        .add(QuestionEvent());
  }

  void menuRaise() {
    BlocProvider.of<AppAnimateBloc>(prefs.context())
        .add(AppAnimateEventRaise());
  }
}
