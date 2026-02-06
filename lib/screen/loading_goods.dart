import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/bloc/http_bloc.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/screen/loading_details.dart';
import 'package:picassostore/utils/calendar.dart';
import 'package:picassostore/utils/dialogs.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/qty_dialog.dart';

class LoadingGoods extends WMApp {
  final GlobalKey<_LoadingGoodsState> _goodsContentState = GlobalKey();

  LoadingGoods({super.key, required super.model});

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
  Widget body(BuildContext context) =>
      _LoadingGoodsContent(key: _goodsContentState, model: model);
}

class _LoadingGoodsContent extends StatefulWidget {
  final WMModel model;

  const _LoadingGoodsContent({super.key, required this.model});

  @override
  State<StatefulWidget> createState() => _LoadingGoodsState(model);
}

class _LoadingGoodsState extends State<_LoadingGoodsContent> {
  static const httpMark = 'e906b242-558c-11f0-a43a-8a884be02f31';
  var _dateTime = DateTime.now();
  final WMModel model;
  final _controller = TextEditingController();
  Timer? _debounceTimer;
  var _isLoading = false;
  final FocusNode _focusNode = FocusNode();

  _LoadingGoodsState(this.model);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onInputChanged);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 10), () {
          FocusScope.of(context).requestFocus(_focusNode);
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(onTap: _changeDate, child: Text(prefs.dateText(_dateTime)))
      ]),
      Row(children: [
        Expanded(
            child: TextField(
          focusNode: _focusNode,
          autofocus: true,
          readOnly: !isSameDate(_dateTime, DateTime.now()),
          controller: _controller,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.none,
        ))
      ]),
      const SizedBox(height: 10),
      BlocConsumer<HttpBloc, HttpState>(
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
            final l = state.data['goods'] ?? [];
            if ((state.data['filter'] ?? 0) > 0) {
              final e = l.firstWhere((e) => e['f_id'] == state.data['filter']);
              if (e != null) {
                l.clear();
                l.add(e);
              }
            }
            return Expanded(
                child: Column(children: [
              Row(children: [
                SizedBox(width: 200, child: Text(locale().goodsName)),
                Expanded(child: Container()),
                SizedBox(width: 50, child: Icon(Icons.downloading)),
                SizedBox(width: 50, child: Icon(Icons.download_done))
              ]),
              Divider(),
              Expanded(
                  child: ListView.separated(
                itemCount: l.length,
                itemBuilder: (context, index) {
                  final e = l[index];
                  final bgColor = e['f_doneqty'] < e['f_qty']
                      ? Colors.white
                      : e['f_doneqty'] == e['f_qty']
                          ? Colors.green
                          : Colors.red;
                  return InkWell(
                      onTap: () => _openDetails(e['f_id']),
                      child: Container(
                          padding:
                              const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          decoration: BoxDecoration(color: bgColor),
                          child: Row(children: [
                            Expanded(child: Text(e['f_name'])),
                            SizedBox(
                                width: 50,
                                child: Text(
                                  prefs.mdFormatDouble(e['f_qty']),
                                  textAlign: TextAlign.center,
                                )),
                            SizedBox(
                                width: 50,
                                child: InkWell(onTap: ()=> _done(e), child: Text(
                                    prefs.mdFormatDouble(e['f_doneqty']),
                                    textAlign: TextAlign.center)))
                          ])));
                },
                separatorBuilder: (context, index) => Divider(),
              ))
            ]));
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
      )
    ]);
  }

  void _refresh() {
    BlocProvider.of<HttpBloc>(prefs.context()).add(HttpEvent({
      'class': 'loadinggoods',
      'method': 'get',
      'date': prefs.dateMySqlText(_dateTime),
      'store': Prefs.config['store']
    }, httpMark));
  }

  void _changeDate() {
    Calendar.show(
            firstDate: _dateTime.add(Duration(days: -30)),
            currentDate: _dateTime)
        .then((d) {
      if (d != null) {
        _dateTime = d;
        setState(() {});
        _refresh();
      }
    });
  }

  void _onInputChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    var code = _controller.text;
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      if (code.isNotEmpty) {
        debugInfo('Now where process the "$code"');
        _processCode(code);
        code = '';
        _controller.clear();
      }
    });
  }

  void _processCode(String code) {
    if (kDebugMode) {
      print('Code $code');
    }
    BlocProvider.of<HttpBloc>(prefs.context()).add(HttpEvent({
      'class': 'loadinggoods',
      'method': 'barcode',
      'date': prefs.dateMySqlText(_dateTime),
      'store': Prefs.config['store'],
      'barcode': code,
      'qty':1
    }, httpMark));
  }

  void _openDetails(int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => LoadingGoodsDetails(
                model: model, date: _dateTime, goods: id))).then((v) {
      _refresh();
    });
  }

  void _done(dynamic d) {
    QtyDialog().getQty().then((qty) {
      if ((qty ?? 0) == 0) {
        return;
      }
      BlocProvider.of<HttpBloc>(prefs.context()).add(HttpEvent({
        'class': 'loadinggoods',
        'method': 'barcode',
        'date': prefs.dateMySqlText(_dateTime),
        'store': Prefs.config['store'],
        'barcode': d['f_scancode'],
        'qty': qty
      }, httpMark));
    });
  }
}
