import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WMModel {

  final serverTextController = TextEditingController();
  final serverUserTextController = TextEditingController();
  final serverPasswordTextController = TextEditingController();

  String tr(String s) {
    return s;
  }

  void registerOnServer() {
    prefs.setString('serveraddress', serverTextController.text);
    BlocProvider.of<AppBloc>(Prefs.navigatorKey.currentContext!).add(AppEventLoading(tr('Registering on server'), 'engine/register-on-server.php', {
      'username': serverUserTextController.text,
      'password': serverPasswordTextController.text
    }));
  }

  void closeDialog() {
    BlocProvider.of<AppBloc>(Prefs.navigatorKey.currentContext!).add(AppEvent());
  }
}