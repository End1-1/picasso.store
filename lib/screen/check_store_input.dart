import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'app.dart';

class WMCheckStoreInput extends WMApp {
  WMCheckStoreInput({super.key, required super.model});

  @override
  String titleText() {
    return model.tr('Check store input');
  }

  @override
  Widget body() {
    return Column(
      children: [],
    );
  }

}