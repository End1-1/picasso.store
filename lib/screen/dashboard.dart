import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'app.dart';

part 'dashboard.model.dart';

part 'dashboard.hotel.dart';

part 'dashboard.store.dart';

class WMDashboard extends WMApp {
  final _model = DashboardModel();

  WMDashboard({super.key, required super.model}) {
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
  List<Widget> actions() {
    return [
      IconButton(onPressed: getDashboard, icon: const Icon(Icons.refresh)),
      if (Prefs.config['dashboard'] == 'hotel') ...actionsHotel(),
      IconButton(onPressed: model.menuRaise, icon: const Icon(Icons.menu))
    ];
  }

  @override
  List<Widget> menuWidgets() {
    switch (Prefs.config['dashboard']) {
      case 'shop':
        return [];
      case 'store':
        return menuWidgetsStore();
      case 'hotel':
        return menuWidgetsHotel();
      default:
        return [
          Styling.menuButton(
              model.navigation.settings, 'config', model.tr('Configuration')),
          Styling.menuButton(
              model.navigation.logout, 'logout', model.tr('Logout')),
        ];
    }
  }

  @override
  Widget body() {
    switch (Prefs.config['dashboard']) {
      case 'shop':
        return Container();
      case 'store':
        return Container();
      case 'hotel':
        return bodyHotel();
      default:
        return Container();
    }
  }
}
