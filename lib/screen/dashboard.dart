import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app.dart';

class WMDashboard extends WMApp {
  WMDashboard({required super.model});

  @override
  Widget? leadingButton(BuildContext context){
    return IconButton(onPressed: (){}, icon: Icon(Icons.menu_sharp));
  }

  @override
  Widget body() {
    return Container();
  }

}