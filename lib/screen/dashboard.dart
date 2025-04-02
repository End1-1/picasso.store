import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:picassostore/bloc/app_bloc.dart';
import 'package:picassostore/bloc/question_bloc.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/utils/calendar.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/styles.dart';

import 'app.dart';
import 'draft_sale.dart';

part 'dashboard.model.dart';
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
      IconButton(onPressed: model.menuRaise, icon: const Icon(Icons.menu))
    ];
  }

  @override
  List<Widget> menuWidgets() {
    return [
      Styling.menuButton(
          model.navigation.settings, 'config', model.tr('Configuration')),
      Styling.menuButton(model.navigation.logout, 'logout', model.tr('Logout')),
    ];
  }

  @override
  Widget body(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                runSpacing: 10,
                children: [
              if (Prefs.config['chm_neworder'] ?? false)
                _bodyButton(model.navigation.newOrder, 'assets/drafts.png',
                    locale().newOrder),
              if (Prefs.config['chm_orders'] ?? false)
                _bodyButton(model.navigation.orders, 'assets/storage.png',
                    locale().orders),
              if (Prefs.config['chm_completedorders'] ?? false)
                _bodyButton(model.navigation.completedOrders,
                    'assets/completedorders.png', locale().completedOrders),
              if (Prefs.config['chm_debts'] ?? false)
                _bodyButton(
                    model.navigation.debts, 'assets/debts.png', locale().debts),
              if (Prefs.config['chm_checkqty'] ?? false)
                _bodyButton(model.navigation.checkQuantity,
                    'assets/storage.png', locale().checkQty),
              if (Prefs.config['chm_draftsale'] ?? false)
                _bodyButton(model.navigation.createDraftSale,
                    'assets/drafts.png', locale().createDraftSale),
              if (Prefs.config['chm_storeinputcheck'] ?? false)
                _bodyButton(() {
                  model.navigation.checkStoreInput();
                }, 'assets/storeinput.png', locale().checkStoreInput),
              if (Prefs.config['chm_saleoutconfirmation'] ?? false)
                _bodyButton(model.navigation.deliveryNote, 'assets/storage.png',
                    locale().deliveryNote),
              if (Prefs.config['chm_returngoods'] ?? false)
                _bodyButton(model.navigation.returnGoods, 'assets/drafts.png',
                    locale().returnGoods),
            ]))
      ])
    ]);
    //    return bodyStore();
  }

  Widget _bodyButton(GestureTapCallback onTap, String icon, String title) {
    return InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 120,
          width: 120,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: Colors.blueGrey)),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset(icon, height: 30),
            Text(title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
          ]),
        ));
  }
}
