import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/bloc/question_bloc.dart';
import 'package:cafe5_mworker/main.dart';
import 'package:cafe5_mworker/model/model.dart';
import 'package:cafe5_mworker/screen/check_qty.dart';
import 'package:cafe5_mworker/screen/check_room_availability.dart';
import 'package:cafe5_mworker/screen/check_store_input.dart';
import 'package:cafe5_mworker/screen/config.dart';
import 'package:cafe5_mworker/screen/goods_info.dart';
import 'package:cafe5_mworker/screen/goods_reserve.dart';
import 'package:cafe5_mworker/screen/login.dart';
import 'package:cafe5_mworker/screen/qr_reader.dart';
import 'package:cafe5_mworker/screen/room_reserve.dart';
import 'package:cafe5_mworker/screen/rooms.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navigation {
  final WMModel model;

  Navigation(this.model);

  Future<void> config() {
    return Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => WMConfig(model: model)));
  }

  Future<void> checkRoomAvailability() {
    hideMenu();
    return Navigator.push(prefs.context(), MaterialPageRoute(builder: (builder) => WMCheckRoomAvaiability(model: model)));
  }

  Future<void> rooms() {
    hideMenu();
    return Navigator.push(prefs.context(), MaterialPageRoute(builder: (builder) => WMRoomsScreen(model: model, entry: DateTime.now(), departure: DateTime.now())));
  }

  Future<void> checkQuantity() {
    hideMenu();
    return Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => WMCheckQty(model: model)));
  }

  Future<void> checkStoreInput() {
    hideMenu();
    return Navigator.push(prefs.context(), MaterialPageRoute(builder: (builder) => WMCheckStoreInput(model: model)));
  }

  Future<void> settings() {
    hideMenu();
    model.serverTextController.text = prefs.string('serveraddress');
    return Navigator.push(prefs.context(), MaterialPageRoute(builder: (builder) => WMConfig(model: model)));
  }

  void logout() {
    hideMenu();
    BlocProvider.of<QuestionBloc>(prefs.context()).add(QuestionEventRaise(model.tr('Logout?'), (){
      BlocProvider.of<QuestionBloc>(Prefs.navigatorKey.currentContext!)
          .add(QuestionEvent());
      BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(model.tr('Logout'), 'engine/logout.php', {}, (e, d) {
        if (!e) {
          prefs.setBool('stayloggedin', false);
          prefs.setString('sessionkey', '');
          Navigator.pushAndRemoveUntil(prefs.context(), MaterialPageRoute(builder: (builder) =>  App()), (route) => false);
        }
      }, null));
    }, null));

  }

  void hideMenu() {
    BlocProvider.of<AppAnimateBloc>(prefs.context()).add(AppAnimateEvent());
  }

  Future<String?> readBarcode() async {
    return Navigator.push(prefs.context(), MaterialPageRoute(builder: (builder) => WMQRReader()));
  }

  Future<Object?> goodsInfo(Map<String,dynamic> info) async {
    return Navigator.push(prefs.context(), MaterialPageRoute(builder: (builder) => WMGoodsInfo(info, model: model)));
  }

  Future<bool?> goodsReservation(Map<String, dynamic> info, Map<String,dynamic> store) async {
    return Navigator.push(prefs.context(), MaterialPageRoute(builder: (builder) => WMGoodsReserve(info, store, model: model)));
  }

  Future<void> openRoom(dynamic r) {
    return Navigator.push(prefs.context(), MaterialPageRoute(builder: (builder) => WMRoomReserve(model: model, room: r)));
  }
}
