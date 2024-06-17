part of 'dashboard.dart';

extension DashboardHotel on WMDashboard {
  List<Widget> actionsHotel() {
    return [
      IconButton(
          onPressed: model.navigation.openRoomChart,
          icon: const Icon(Icons.table_chart_outlined)),
    ];
  }

  List<Widget> menuWidgetsHotel() {
    return [
      Styling.menuButton(model.navigation.checkRoomAvailability, 'forecast',
          model.tr('Check room availability')),
      Styling.menuButton(model.navigation.rooms, 'forecast', model.tr('Rooms')),
      Styling.menuButton(
          model.navigation.settings, 'config', model.tr('Configuration')),
      Styling.menuButton(model.navigation.logout, 'logout', model.tr('Logout')),
    ];
  }

  Widget bodyStore() {
    return BlocBuilder<AppBloc, AppState>(
        buildWhen: (p, c) => c is AppStateDashboard,
        builder: (builder, state) {
          if (state is! AppStateDashboard) {
            return Container();
          }
          return SingleChildScrollView(
              child: Column(
              children: [
                for (final e in _model.drafts) ... [
                  InkWell(
                    onTap:(){openDraft(e['f_id']);},
                      child: Row(children: [
                    SizedBox(width: 120, child: Styling.text('${e['f_date']}')),
                    SizedBox(width: 100, child: Styling.text('${e['f_amount']}'))
                  ])),
                  Divider(),
                ]
              ]));
        });
  }

  Widget bodyHotel() {
    return BlocBuilder<AppBloc, AppState>(
        buildWhen: (p, c) => c is AppStateDashboard,
        builder: (builder, state) {
          if (state is! AppStateDashboard) {
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
