import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/model/model.dart';
import 'package:cafe5_mworker/screen/check_qty.dart';
import 'package:cafe5_mworker/screen/config.dart';
import 'package:cafe5_mworker/screen/goods_info.dart';
import 'package:cafe5_mworker/screen/goods_reserve.dart';
import 'package:cafe5_mworker/screen/qr_reader.dart';
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

  Future<void> checkQuantity() {
    hideMenu();
    model.scancodeTextController.clear();
    return Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => WMCheckQty(model: model)));
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

  Future<Object?> goodsReservation(Map<String, dynamic> info, Map<String,dynamic> store) async {
    model.reserveQtyTextController.clear();
    model.reserveCommentTextController.clear();
    return Navigator.push(prefs.context(), MaterialPageRoute(builder: (builder) => WMGoodsReserve(info, store, model: model)));
  }
}
