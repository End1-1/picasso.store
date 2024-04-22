import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';

part 'dashboard.model.dart';

class WMDashboard extends WMApp {
  WMDashboard({required super.model}) {
    getDashboard();
  }

  @override
  Widget? leadingButton(BuildContext context) {
    return null;
  }

  @override
  String titleText() {
    return Prefs.config['first_page_title'] ?? 'Picasso';
  }

  @override
  List<Widget> menuWidgets() {
    return [
      Styling.menuButton(model.navigation.checkRoomAvailability, 'forecast', model.tr('Check room availability')),
      Styling.menuButton(model.navigation.rooms, 'forecast', model.tr('Rooms')),
      Styling.menuButton(model.navigation.checkQuantity, 'available', model.tr('Check availability')),
      Styling.menuButton(model.navigation.checkStoreInput, 'checkstoreinput', model.tr('Check store input')),
      Styling.menuButton(model.navigation.settings, 'config', model.tr('Configuration')),
      Styling.menuButton(model.navigation.logout, 'logout', model.tr('Logout')),

    ];
  }

  @override
  Widget body() {
    return Column(
      children: [
        Row(children:[Text(model.tr('Todays checkin')), Expanded(child: Container()), Text('4')]),
        Row(children:[Text(model.tr('Inhouse guests')), Expanded(child: Container()), Text('35')]),
        Row(children:[Text(model.tr('Todays checkout')), Expanded(child: Container()), Text('8')]),
        Row(children:[Text(model.tr('Payments, cash')), Expanded(child: Container()), Text('123,500')]),

      ],
    );
  }
}
