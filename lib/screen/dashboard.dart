import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';

class WMDashboard extends WMApp {
  WMDashboard({required super.model}) {
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        model.tr('Wait, please'), 'engine/dashboard.php', {}, (e, d) {}));
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
      Styling.menuButton(model.navigation.checkQuantity, 'available', model.tr('Check availability')),
      Styling.menuButton(model.navigation.checkStoreInput, 'checkstoreinput', model.tr('Check store input')),
      Styling.menuButton(model.navigation.settings, 'config', model.tr('Configuration')),
      Styling.menuButton(model.navigation.logout, 'logout', model.tr('Logout')),

    ];
  }

  @override
  Widget body() {
    return Container();
  }
}
