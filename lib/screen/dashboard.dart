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
  List<Widget> menuWidgets() {
    return [
      Styling.menuButton(model.navigation.checkQuantity, 'available',
          model.tr('Check availability'))
    ];
  }

  @override
  Widget body() {
    return Container();
  }
}
