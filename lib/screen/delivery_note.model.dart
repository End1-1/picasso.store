import 'package:flutter/material.dart';
import 'package:picassostore/model/goods.dart';
import 'package:picassostore/utils/prefs.dart';


class DocModel {
  var id = '';
  final List<Goods> goods = [];
  final goodsCheck = <String, double>{};
  final List<String> codes = [];
  final List<String> qrCode = [];

  void count() {
    for (final q in goodsCheck.keys) {
      goodsCheck[q] = 0;
    }
    for (var e in codes) {
      goodsCheck[e] = (goodsCheck[e] ?? 0) + 1;
    }
  }

  void setOk(String barcode) {
    final g = goods.where((e) => e.sku == barcode).toList().first;
    goodsCheck[barcode] = g.qty;
    Navigator.pop(prefs.context());
  }

  void setNotOk(String barcode) {
    goodsCheck[barcode] = 0;
    Navigator.pop(prefs.context());
  }

  String barcodeFromQr(String qr) {
    String barcode = qr;
    if (qr.length > 7) {
      if (qr.substring(0, 6) == "000000") {
        barcode = qr.substring(6, 14);
      } else if (qr.substring(0, 3) == "010") {
        if (qr.substring(0, 8) == "01000000") {
          barcode = qr.substring(8, 16);
        } else {
          barcode = qr.substring(3, 16);
        }
      } else {
        barcode = qr.substring(1, 9);
      }
    }
    return barcode;
  }
}