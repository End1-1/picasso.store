import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
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
    return IconButton(onPressed: () {}, icon: Icon(Icons.menu_sharp));
  }

  @override
  Widget body() {
    return Container();
  }
}
