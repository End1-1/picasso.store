import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:picassostore/bloc/http_bloc.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/utils/calendar_range.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/styles.dart';

class CompletedOrders extends WMApp {
  var _dateStart = DateTime.now();
  var _dateEnd = DateTime.now();
  static const httpMark = '4398e3ea-0ad6-11f0-9700-7c10c9bcac82';

  CompletedOrders({required super.model});

  @override
  String titleText() {
    return locale().completedOrders;
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
      IconButton(onPressed: model.menuRaise, icon: const Icon(Icons.menu)),
    ];
  }

  @override
  List<Widget> menuWidgets() {
    return [
      Styling.menuButton2(_setDateRange, 'calendar', locale().date),
    ];
  }

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<HttpBloc, HttpState>(
        buildWhen: (p, c) => c.mark == httpMark,
        builder: (context, state) {
          if (state.state == 0 || state.mark != httpMark) {
            Future.microtask(() => _refresh());

            return Center(child: CircularProgressIndicator());
          }
          if (state.state == 3) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.state == 1) {
            return Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(child: Text(state.data ?? '')))
              ],
            );
          }
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return _row(state.data[index], index);
                      }))
            ],
          );
        });
  }

  Widget _row(dynamic d, int i) {
    return InkWell(
        onTap: () {
          model.navigation.openOrder(d['f_id']);
        },
        child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: i % 2 == 0 ? Colors.black12 : Colors.black26),
            child: Column(children: [
              Row(children: [
                Text('${i + 1}.'),
                Text(d['f_address'] ?? 'No address')
              ]),
              Row(children: [
                Expanded(child: Text(d['f_taxname'] ?? 'No taxpayername')),
                Text(d['f_taxcode'] ?? '')
              ]),
              Row(children: [
                Expanded(child: Text('')),
                Text(prefs
                    .mdFormatDouble((d['f_amounttotal'] as num).toDouble()))
              ])
            ])));
  }

  void _refresh() {
    BlocProvider.of<HttpBloc>(prefs.context()).add(HttpEvent({
      'class': 'draft',
      'method': 'getCompletedOrders',
      'datestart': DateFormat('yyyy-MM-dd').format(_dateStart),
      'dateend': DateFormat('yyyy-MM-dd').format(_dateEnd)
    }, httpMark));
  }

  void _setDateRange() {
    model.navigation.hideMenu();
    DateFilterDialog.showDateFilterDialog(_dateStart, _dateEnd).then((d) {
      if (d != null) {
        _dateStart = d['start']!;
        _dateEnd = d['end']!;
        _refresh();
      }
    });
  }
}
