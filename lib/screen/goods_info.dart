import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'app.dart';

class WMGoodsInfo extends WMApp {
  final Map<String, dynamic> info;
  WMGoodsInfo(this.info, {required super.model});

  @override
  String titleText() {
    return info['f_goodsname'];
  }

  @override
  Widget body() {
   return Container();
  }

}