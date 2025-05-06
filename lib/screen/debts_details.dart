import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:picassostore/bloc/http_bloc.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/utils/calendar_range.dart';
import 'package:picassostore/utils/prefs.dart';

class DebtsDetails extends WMApp {
  static const httpMark = 'f0512a3b-16a0-11f0-95f8-7c10c9bcac82';
  static const rs = TextStyle(color: Colors.red);
  static const gs = TextStyle(color: Colors.green);
  final int partner;
  var date1 = DateTime.now();
  var date2 = DateTime.now();

  DebtsDetails({required this.partner, super.key, required super.model}) {
    _refresh();
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
      IconButton(
          onPressed: _filter, icon: const Icon(Icons.filter_alt_outlined)),
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
                        final n = state.data[index];
                        if (index == 0) {
                          return Column(children: [
                            Row(children: [
                              Expanded(
                                  child: Text(
                                      '${locale().debtAsOf} ${DateFormat('dd/MM/yyyy').format(date1)}',
                                      style: n['f_amount'] < 0 ? rs : gs)),
                              Text(prefs.mdFormatDouble(n['f_amount']),
                                  style: n['f_amount'] < 0 ? rs : gs)
                            ]),
                            Divider()
                          ]);
                        }
                        return _row(n, index);
                      }))
            ],
          );
        });
  }

  Widget _row(dynamic d, int i) {
    return InkWell(
        onTap: () {
          if (((d['f_order'] ?? '') as String).isNotEmpty) {
            model.navigation.openOrder(d['f_order']);
            return;
          }
        },
        child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: i % 2 == 0 ? Colors.black12 : Colors.black26),
            child: Column(children: [
              Row(children: [
                Expanded(
                    child: Text(d['f_purpose'],
                        style: d['f_amount'] < 0 ? rs : gs)),
                Text(prefs.mdFormatDouble(d['f_amount']),
                    style: d['f_amount'] as num < 0 ? rs : gs)
              ])
            ])));
  }

  void _refresh() {
    BlocProvider.of<HttpBloc>(prefs.context()).add(HttpEvent({
      'class': 'debts',
      'method': 'getPartnerDebts',
      'partner': partner,
      'date1': DateFormat('yyyy-MM-dd').format(date1),
      'date2': DateFormat('yyyy-MM-dd').format(date2)
    }, httpMark));
  }

  void _filter() {
    DateFilterDialog.showDateFilterDialog(date1, date2).then((d) {
      if (d != null) {
        date1 = d['start']!;
        date2 = d['end']!;
        _refresh();
      }
    });
  }
}
