import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/bloc/date_bloc.dart';
import 'package:cafe5_mworker/bloc/question_bloc.dart';
import 'package:cafe5_mworker/screen/dashboard.dart';
import 'package:cafe5_mworker/screen/login.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation.dart';

part 'check_store_input_model.dart';

class WMModel {
  final serverTextController = TextEditingController();
  final serverUserTextController = TextEditingController();
  final serverPasswordTextController = TextEditingController();
  final configPinTextController = TextEditingController();
  final scancodeTextController = TextEditingController();
  final reserveQtyTextController = TextEditingController();
  final reserveCommentTextController = TextEditingController();
  final scancodeFocus = FocusNode();

  late final Navigation navigation;

  var reservationExpiration = DateTime.now();
  var reservationStore = 0;
  var reservationGoods = 0;
  var reservationGoodsName = '';
  var maxReserveQty = 0.0;

  WMModel() {
    navigation = Navigation(this);
  }

  String tr(String s) {
    return Res.tr[s] ?? s;
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
        Navigator.pop(prefs.context(), true);
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
        prefs.setString('config', d['config']['f_config']);
        prefs.init();
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
        prefs.setString('config', d['config']['f_config']);
        prefs.init();
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

  void closeQuestionDialog() {
    BlocProvider.of<QuestionBloc>(Prefs.navigatorKey.currentContext!)
        .add(QuestionEvent());
  }

  void searchBarcode(String b) {
    if (b.isEmpty) {
      return;
    }
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        tr('Checking availability'),
        'engine/reports/availability.php',
        {'barcode': b},
        (e, d) {}));
  }
  
  void searchBarcodeStoreInput(String b) {
    if (b.isEmpty) {
      return;
    }
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading('Querying', 'engine/worker/store-input-check-barcode.php', {
      'barcode':b,
      'store': Prefs.config['store'] ?? 0,
      'mode': 1
    }, (e, d) {

    }));
  }

  void setReservationExpiration() {
    showDatePicker(
            context: prefs.context(),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)))
        .then((value) {
      if (value != null) {
        reservationExpiration = value;
        BlocProvider.of<DateBloc>(prefs.context()).add(DateEvent());
      }
    });
  }

  void reserveQtyChanged(String s) {
    var nv = double.tryParse(s) ?? 0;
    if (nv > maxReserveQty) {
      nv = maxReserveQty;
      reserveQtyTextController.text = prefs.df(nv.toString());
    }
  }

  void createReservation() {
    var err = '';
    var qty = double.tryParse(reserveQtyTextController.text) ?? 0;
    if (qty < 1) {
      err += tr('Quantity is not set');
      err += '\r\n';
    }
    if (err.isNotEmpty) {
      BlocProvider.of<AppBloc>(prefs.context()).add(AppEventError(err));
      return;
    }
    Map<String, dynamic> d = {
      'source': Prefs.config['store'] ?? 0,
      'store': reservationStore,
      'goods': reservationGoods,
      'goodsname': reservationGoodsName,
      'qty': double.tryParse(reserveQtyTextController.text) ?? 0,
      'message': reserveCommentTextController.text,
      'enddate': prefs.dateMySqlText(reservationExpiration),
    };
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        tr('Create reservation'), 'engine/worker/create-reservation.php', d,
        (e, s) {
      if (e) {
      } else {
        Navigator.pop(prefs.context(), true);
      }
    }));
  }

  void replaceBarcodeSize(String ss) {
    String s = scancodeTextController.text;
    if (s.length < 2) {
      return;
    }
    s = s.replaceRange(0, 2, ss);
    scancodeTextController.text = s;
    searchBarcode(s);
  }

  void readBarcode() {
    navigation.readBarcode().then((value) {
      if (value != null) {
        scancodeTextController.text = value;
        searchBarcode(scancodeTextController.text);
      }
    });
  }

  void checkBarcodeStoreInput() {
    navigation.readBarcode().then((value) {
      if (value != null) {
        scancodeTextController.text = value;
        searchBarcodeStoreInput(scancodeTextController.text);
      }
    });
  }
}
