import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/bloc/http_bloc.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/utils/dialogs.dart';
import 'package:picassostore/utils/prefs.dart';

import 'app.dart';

class LoadingGoodsDetails extends WMApp {
  final DateTime date;
  final int goods;
  final GlobalKey<_LoadingGoodsDetailsState> _goodsContentState = GlobalKey();

  LoadingGoodsDetails(
      {super.key,
      required super.model,
      required this.date,
      required this.goods});

  @override
  List<Widget> actions() {
    return [
      IconButton(
          onPressed: _goodsContentState.currentState?._refresh,
          icon: const Icon(Icons.refresh)),
    ];
  }

  @override
  String titleText() {
    return locale().loadingGoods;
  }

  @override
  Widget body(BuildContext context) => _LoadingGoodsDetailsContent(
      key: _goodsContentState, model: model, date: date, goods: goods);
}

class _LoadingGoodsDetailsContent extends StatefulWidget {
  final WMModel model;
  final DateTime date;
  final int goods;

  const _LoadingGoodsDetailsContent(
      {super.key,
      required this.model,
      required this.date,
      required this.goods});

  @override
  State<StatefulWidget> createState() =>
      _LoadingGoodsDetailsState(model, date: date, goods: goods);
}

class _LoadingGoodsDetailsState extends State<_LoadingGoodsDetailsContent> {
  final WMModel model;
  static const httpMark = '44d62466-5722-11f0-a43a-8a884be02f31';
  final DateTime date;
  final int goods;

  _LoadingGoodsDetailsState(this.model,
      {required this.date, required this.goods});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HttpBloc, HttpState>(
      buildWhen: (p, c) => c.mark == httpMark,
      builder: (context, state) {
        if (state.state == 0 || state.mark != httpMark) {
          Future.microtask(() => _refresh());
          return Center(child: CircularProgressIndicator());
        }
        if (state.state == 3) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.state == 2) {
          final l = state.data['details'] ?? [];
          return Column(children: [
            Row(children: [
              SizedBox(width: 200, child: Text(state.data['goodsname'])),
              Expanded(child: Container()),
              SizedBox(width: 50, child: Icon(Icons.download_done))
            ]),
            Divider(),
            Expanded(
                child: ListView.separated(
              itemCount: l.length,
              itemBuilder: (context, index) {
                final e = l[index];
                return Dismissible(
                    key: Key(e['f_id'].toString()),
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: isSameDate(date, DateTime.now()) ? DismissDirection.endToStart : DismissDirection.none,
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(locale().deleting),
                          content: Text(locale().removalConfirmation),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.of(ctx).pop(false),
                                child: Text(locale().cancel)),
                            TextButton(
                                onPressed: () => Navigator.of(ctx).pop(true),
                                child: Text(locale().ok)),
                          ],
                        ),
                      );
                    },
                    onDismissed: (direction) {
                      BlocProvider.of<HttpBloc>(prefs.context()).add(HttpEvent({
                        'class': 'loadinggoods',
                        'method': 'remove',
                        'date': prefs.dateMySqlText(date),
                        'store': Prefs.config['store'],
                        'id': e['f_id'],
                        'goods': goods
                      }, httpMark));
                    },
                    child: Container(
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        decoration: BoxDecoration(color: Colors.white38),
                        child: Row(children: [
                          Expanded(child: Text(e['f_time'] ?? 'UNKNNOW')),
                          SizedBox(
                              width: 50,
                              child: Text(
                                prefs.mdFormatDouble(e['f_qty']),
                                textAlign: TextAlign.center,
                              ))
                        ])));
              },
              separatorBuilder: (context, index) => Divider(),
            ))
          ]);
        }
        if (state.state == 2) {
          return Text(state.data);
        }
        return Container();
      },
      listener: (BuildContext context, HttpState state) {
        if (state.state == 1) {
          showErrorDialog(state.data);
        }
      },
    );
  }

  void _refresh() {
    BlocProvider.of<HttpBloc>(prefs.context()).add(HttpEvent({
      'class': 'loadinggoods',
      'method': 'details',
      'date': prefs.dateMySqlText(date),
      'store': Prefs.config['store'],
      'goods': goods
    }, httpMark));
  }
}
