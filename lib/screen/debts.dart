import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/bloc/http_bloc.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/utils/prefs.dart';

class Debts extends WMApp {
  static const httpMark = 'fdded085-0ad5-11f0-9523-02c88e00dcd1';
  Debts({super.key, required super.model});

  @override
  String titleText() {
    return locale().debts;
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
    ];
  }

  @override
  Widget body() {
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

  void _refresh() {
    BlocProvider.of<HttpBloc>(prefs.context()).add(
        HttpEvent({'class': 'debts', 'method': 'getAll'}, httpMark));
  }

  Widget _row(dynamic d, int i){
     return InkWell(
        onTap: () {

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
                Text(prefs.mdFormatDouble((d['f_amount'] as num).toDouble()))
              ])
            ])));
  }
}