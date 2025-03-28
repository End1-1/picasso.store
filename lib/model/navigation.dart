import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/bloc/app_bloc.dart';
import 'package:picassostore/bloc/http_bloc.dart';
import 'package:picassostore/bloc/question_bloc.dart';
import 'package:picassostore/main.dart';
import 'package:picassostore/mobiles_scanner/barcode_reader.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/screen/check_qty.dart';
import 'package:picassostore/screen/check_store_input.dart';
import 'package:picassostore/screen/completed_orders.dart';
import 'package:picassostore/screen/config.dart';
import 'package:picassostore/screen/debts.dart';
import 'package:picassostore/screen/deliver_note.dart';
import 'package:picassostore/screen/draft_sale.dart';
import 'package:picassostore/screen/goods_info.dart';
import 'package:picassostore/screen/goods_reserve.dart';
import 'package:picassostore/screen/new_order.dart';
import 'package:picassostore/screen/order.dart';
import 'package:picassostore/screen/orders.dart';
import 'package:picassostore/utils/prefs.dart';

class Navigation {
  final WMModel model;

  Navigation(this.model);

  Future<void> config() {
    return Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => WMConfig(model: model)));
  }

  Future<void> createDraftSale() {
    hideMenu();
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) => WMDraftSale(model: model, draftid: '')));
  }

  Future<void> checkQuantity() {
    hideMenu();
    return Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => WMCheckQty(model: model)));
  }

  Future<void> checkStoreInput() {
    hideMenu();
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) => WMCheckStoreInput(model: model)));
  }

  Future<void> settings() {
    hideMenu();
    model.serverTextController.text = prefs.string('serveraddress');
    model.serverUserTextController.clear();
    model.serverPasswordTextController.clear();
    return Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => WMConfig(model: model)));
  }

  Future<void> deliveryNote() {
    hideMenu();
    return Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => DeliveryNote(model: model)));
  }

  Future<void> returnGoods() {
    hideMenu();
    return Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => DeliveryNote(model: model)));
  }

  void logout() {
    hideMenu();
    BlocProvider.of<QuestionBloc>(prefs.context())
        .add(QuestionEventRaise(model.tr('Logout?'), () {
      BlocProvider.of<QuestionBloc>(Prefs.navigatorKey.currentContext!)
          .add(QuestionEvent());
      BlocProvider.of<AppBloc>(prefs.context()).add(
          AppEventLoading(model.tr('Logout'), 'engine/logout.php', {}, (e, d) {
        prefs.setBool('stayloggedin', false);
        prefs.setString('sessionkey', '');
        Navigator.pushAndRemoveUntil(prefs.context(),
            MaterialPageRoute(builder: (builder) => App()), (route) => false);
      }, AppStateFinished(data: null)));
    }, null));
  }

  void hideMenu() {
    BlocProvider.of<AppAnimateBloc>(prefs.context()).add(AppAnimateEvent());
  }

  Future<String?> readBarcode() async {
    return Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => BarcodeScannerWithOverlay()));
  }

  Future<Object?> goodsInfo(Map<String, dynamic> info) async {
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) => WMGoodsInfo(info, model: model)));
  }

  Future<bool?> goodsReservation(
      Map<String, dynamic> info, Map<String, dynamic> store) async {
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) => WMGoodsReserve(info, store, model: model)));
  }

  Future<bool?> openWaiterTable(int table) {
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) => WMOrder(model: model, table: table)));
  }

  Future<void> newOrder() {
    hideMenu();
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) => NewOrder(model: model, orderId: '')));
  }

  Future<void> openOrder(String id) {
    hideMenu();
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) => NewOrder(model: model, orderId: id)));
  }

  Future<void> orders() {
    hideMenu();
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) =>Orders(model: model)));
  }

  Future<void> completedOrders() {
    hideMenu();
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) => CompletedOrders(model: model)));
  }

  Future<void> debts() {
    hideMenu();
    return Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (builder) =>  Debts(model: model)));
  }
}
