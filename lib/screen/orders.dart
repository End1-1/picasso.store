import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/bloc/http_bloc.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/utils/http_query.dart';
import 'package:picassostore/utils/prefs.dart';

class Orders extends WMApp {
  static const httpMark = '39ebda17-0ad5-11f0-9523-02c88e00dcd1';

  Orders({super.key, required super.model});

  @override
  List<Widget> actions() {
    return [
      IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
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
          int i = 0;
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: Key(state.data[index].toString()),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(locale().removeRow),
                                    content: Text(
                                        '${locale().confirmRemoveOrder}\r\n${state.data[index]['f_address'] ?? 'No address'}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text(locale().cancel),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                          _removeOrder(
                                              state.data[index]['f_id']);
                                        },
                                        child: Text(locale().remove),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            background: Container(
                              color: Colors.orange,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              _refresh();
                            },
                            child: _row(state.data[index], index));
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
                Expanded(child: Container()),
                Text(prefs.mdFormatDouble((d['f_amount'] as num).toDouble()))
              ]),
            ])));
  }

  void _refresh() {
    BlocProvider.of<HttpBloc>(prefs.context())
        .add(HttpEvent({'class': 'draft', 'method': 'getDrafts'}, httpMark));
  }

  void _removeOrder(String id) {
    HttpQuery('engine/picasso.store/').request(
        {'class': 'draft', 'method': 'remove', 'id': id}).then((reply) {
      if (reply['status'] != 1) {
        model.error(reply['data']);
      } else {
        _refresh();
      }
    });
  }
}
