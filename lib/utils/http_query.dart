import 'dart:convert';
import 'package:picassostore/main.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpQuery {

  bool needlonglog = false;
  final String route;
  final int timeout;
  HttpQuery(this.route, {this.timeout = 20});

  Future<Map<String, dynamic>> request(Map<String, dynamic> inData) async {
    inData['sessionkey'] = prefs.string('sessionkey');
    inData['appversion'] = prefs.string('appversion');
    inData['app'] = 'picasso.store';
    inData['config'] = prefs.string('config');
    inData['workingday'] = prefs.dateMySqlText(prefs.workingDay());
    inData['language'] = 'am';
    inData['debug'] = false && kDebugMode;
    if (kDebugMode) {
      //inData['appversion'] = prefs.string('appversion');
      //inData['appversion'] = '1.0.3.49';
    }

    Map<String, Object?> outData = {};
    String strBody = jsonEncode(inData);
    if (kDebugMode) {
      if (needlonglog) {
        debugPrint('request ${prefs.string("serveraddress")}/$route: $strBody');
      } else {
          print('request ${prefs.string("serveraddress")}/$route: $strBody');
      }
    }
    try {
      late final http.Response response;
      if (prefs.getBool('donotusessl') ?? false ){
        response = await http
            .post(
            Uri.http(prefs.string("serveraddress"), route),
            headers: {
              'Content-Type': 'application/json',
            },
            body: utf8.encode(strBody))
            .timeout(Duration(seconds: timeout), onTimeout: () {
          return http.Response('Timeout', 408);
        });
      } else {
        response = await http
            .post(
            Uri.https(prefs.string("serveraddress"), route),
            headers: {
              'Content-Type': 'application/json',
            },
            body: utf8.encode(strBody))
            .timeout(Duration(seconds: timeout), onTimeout: () {
          return http.Response('Timeout', 408);
        });
      }

      String strResponse = utf8.decode(response.bodyBytes);
      if (kDebugMode) {
        if (needlonglog) {
          debugPrint('Row body $strResponse');
        } else {
          print('Row body $strResponse');
        }
      }
      if (response.statusCode < 299) {
        try {
          outData = jsonDecode(strResponse);
          if (!outData.containsKey('status')) {
            outData['status'] = 0;
            if (!outData.containsKey('data')) {
              outData['data'] = jsonEncode(outData);
            }
          }
        } catch (e) {
          outData['status'] = 0;
          outData['data'] = '${e.toString()} $strResponse';
        }
      } else {
        outData['status'] = 0;
        outData['error'] = response.statusCode;
        outData['data'] = strResponse;
        if (response.statusCode == 401) {
          prefs.setString('sessionkey', '');
          Prefs.navigatorKey = GlobalKey<NavigatorState>();
          Navigator.pushAndRemoveUntil(prefs.context(), MaterialPageRoute(builder: (builder)=> App()), (route) => false);
        }
      }
    } catch (e) {
      outData['status'] = 0;
      outData['data'] = e.toString();
    }
    if (kDebugMode) {
      if (needlonglog) {
        debugPrint('Output $outData');
      } else {
        print('Output $outData');
      }
    }
    return outData;
  }
}
