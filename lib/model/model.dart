import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/bloc/app_bloc.dart';
import 'package:picassostore/bloc/question_bloc.dart';
import 'package:picassostore/model/goods_group.dart';
import 'package:picassostore/screen/dashboard.dart';
import 'package:picassostore/screen/login.dart';
import 'package:picassostore/utils/app_websocket.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/res.dart';
import 'package:url_launcher/url_launcher.dart';

import 'navigation.dart';

part 'model.menu.dart';

class AppStateAppBar extends AppState {
  AppStateAppBar() ;
}

class AppEventAppBar extends AppEvent {}

class WMModel {
  final serverTextController = TextEditingController();
  final serverKeyController = TextEditingController();
  final serverUserTextController = TextEditingController();
  final serverPasswordTextController = TextEditingController();
  final configPinTextController = TextEditingController();
  final appWebsocket = AppWebSocket();
  final List<GoodsGroup> goodsGroups = [];

  late final Navigation navigation;

  WMModel() {
    navigation = Navigation(this);
  }

  String tr(String s) {
    return Res.tr[s] ?? s;
  }

  void registerDemoServer() {
    prefs.setString('serveraddress', 'home.picasso.am');
    prefs.setString('serverkey', '6b5f0be3-d8f8-11f0-a533-8a884be02f31');
    Navigator.pop(prefs.context(), true);
  }

  void registerOnServer() {
    prefs.setString('serveraddress', serverTextController.text);
    prefs.setString('serverkey', serverKeyController.text);
    Navigator.pop(prefs.context(), true);
  }

  void loginUsernamePassword() {
    BlocProvider.of<AppBloc>(prefs.context())
        .add(AppEventLoading(tr('Sign in'), 'engine/login.php', {
      "username": serverUserTextController.text,
      "password": serverPasswordTextController.text,
      "method": WMLogin.username_password
    }, (e, d) {
      if (!e) {
        try {
          prefs.setString('sessionkey', d['sessionkey']);
          if (d['config']['f_config'] is Map) {
            prefs.setString('config', jsonEncode(d['config']['f_config']));
          } else {
            prefs.setString('config', d['config']['f_config']);
          }
          prefs.setInt('userid', d['user']['f_id']);
          prefs.setString('database', d['database']);
          prefs.setString('username', serverUserTextController.text);
          prefs.setString('password', serverPasswordTextController.text);
          prefs.init();
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
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
        prefs.setInt('userid', d['user']['f_id']);
        prefs.setString('database', d['database']);
      } else {
        prefs.setString('database', d['database']);
        if (d['config']['f_config'] is String) {
          prefs.setString('config', d['config']['f_config']);
        } else {
          prefs.setString('config', jsonEncode(d['config']['f_config']));
        }
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

  void downloadLatestVersion() async {
    launchUrl(Uri.parse('https://download.picasso.am/'),
        mode: LaunchMode.inAppBrowserView);
  }

  void question(String text, VoidCallback ifYes, VoidCallback ifNo) {
    BlocProvider.of<QuestionBloc>(prefs.context())
        .add(QuestionEventRaise(text, ifYes, ifNo));
  }

  void error(String text) {
    BlocProvider.of<AppBloc>(prefs.context())
        .add(AppEventError(text));
  }
}
