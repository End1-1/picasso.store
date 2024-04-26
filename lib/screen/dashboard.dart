import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'app.dart';

part 'dashboard.model.dart';

class WMDashboard extends WMApp {
  final _model = DashboardModel();

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
  List<Widget> actions() {
    return [
      IconButton(onPressed: getDashboard, icon: Icon(Icons.refresh)),
      IconButton(
          onPressed: model.navigation.openRoomChart,
          icon: const Icon(Icons.table_chart_outlined)),
      IconButton(onPressed: model.menuRaise, icon: const Icon(Icons.menu))
    ];
  }

  @override
  List<Widget> menuWidgets() {
    return [
      Styling.menuButton(model.navigation.checkRoomAvailability, 'forecast',
          model.tr('Check room availability')),
      Styling.menuButton(model.navigation.rooms, 'forecast', model.tr('Rooms')),
      Styling.menuButton(model.navigation.checkQuantity, 'available',
          model.tr('Check availability')),
      Styling.menuButton(model.navigation.checkStoreInput, 'checkstoreinput',
          model.tr('Check store input')),
      Styling.menuButton(
          model.navigation.settings, 'config', model.tr('Configuration')),
      Styling.menuButton(model.navigation.logout, 'logout', model.tr('Logout')),
    ];
  }

  @override
  Widget body() {
    return BlocBuilder<AppBloc, AppState>(
        buildWhen: (p, c) => c is AppStateDashboard,
        builder: (builder, state) {
          if (!(state is AppStateDashboard)) {
            return Container();
          }
          final checkin = state.data['checkin'];
          final checkout = state.data['checkout'];
          final inhouse = state.data['inhouse'];
          return SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  color: const Color(0xff84f1ff),
                  child: Row(children: [
                    Styling.textBold(model.tr('Todays checkin')),
                    Expanded(child: Container()),
                    Text('${checkin.length}'),
                    Styling.rowSpacingWidget()
                  ])),
              for (final c in checkin) ...[
                InkWell(
                    onTap: () {
                      model.navigation.openFolio(c);
                    },
                    child: Container(
                        color: const Color(0xff84f1ff),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Styling.text(
                                    '${c['f_startdate']} - ${c['f_enddate']}'),
                                Expanded(child: Container()),
                                Styling.text(c['f_roomshort']),
                                Styling.rowSpacingWidget()
                              ],
                            ),
                            Row(
                              children: [
                                Styling.text(c['f_guests']),
                              ],
                            ),
                            const Divider(),
                          ],
                        )))
              ],
              Container(
                  color: const Color(0xffa7ff84),
                  child: Row(children: [
                    Styling.textBold(model.tr('Inhouse guests')),
                    Expanded(child: Container()),
                    Text('${inhouse.length}'),
                    Styling.rowSpacingWidget()
                  ])),
              Container(
                  color: const Color(0xffa7ff84),
                  child: Column(children: [
                    for (final c in inhouse) ...[
                      InkWell(
                          onTap: () {
                            model.navigation.openFolio(c);
                          },
                          child: Row(
                            children: [
                              Styling.text(
                                  '${c['f_startdate']} - ${c['f_enddate']}'),
                              Expanded(child: Container()),
                              Styling.text(c['f_roomshort']),
                              Styling.rowSpacingWidget()
                            ],
                          )),
                      Row(
                        children: [
                          Styling.text(c['f_guests']),
                        ],
                      ),
                      const Divider()
                    ]
                  ])),
              Container(
                  color: const Color(0xfffff6b3),
                  child: Row(children: [
                    Styling.textBold(model.tr('Todays checkout')),
                    Expanded(child: Container()),
                    Text('${checkout.length}'),
                    Styling.rowSpacingWidget()
                  ])),
              Container(
                  color: const Color(0xfffff6b3),
                  child: Column(children: [
                    for (final c in checkout) ...[
                      InkWell(
                          onTap: () {
                            model.navigation.openFolio(c).then((value) {
                              if (value ?? false) getDashboard();
                            });
                          },
                          child: Row(
                            children: [
                              Styling.text(
                                  '${c['f_startdate']} - ${c['f_enddate']}'),
                              Expanded(child: Container()),
                              Styling.text(c['f_roomshort']),
                              Styling.rowSpacingWidget()
                            ],
                          )),
                      Row(
                        children: [
                          Styling.text(c['f_guests']),
                        ],
                      ),
                      const Divider()
                    ]
                  ])),
              Row(children: [
                Styling.textBold(model.tr('Payments, cash')),
                Expanded(child: Container()),
                Text('${state.data['payment'][0]["f_amountamd"]}')
              ]),
            ],
          ));
        });
  }
}
