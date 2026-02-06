import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/model/goods.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/screen/delivery_note.details.dart';
import 'package:picassostore/utils/http_query.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/styles.dart';

import 'delivery_note.model.dart';

part 'delivery_note.part.dart';

class DeliveryNote extends WMApp {
  final GlobalKey<_DeliveryNoteState> _deliveryNoteState = GlobalKey();

  DeliveryNote({super.key, required super.model});

  @override
  String titleText() {
    return locale().deliveryNote;
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(
          onPressed: _deliveryNoteState.currentState?._confirm,
          icon: Image.asset(
            'assets/confirm.png',
            height: 20,
          )),
      IconButton(
          onPressed: _deliveryNoteState.currentState?._openDoc,
          icon: Icon(
            Icons.file_open_outlined,
            color: Colors.black,
          ))
    ];
  }

  @override
  Widget body(BuildContext context) {
    return _DeliveryNote(key: _deliveryNoteState, model: model);
  }
}

class _DeliveryNote extends StatefulWidget {
  final WMModel model;
  final docModel = DocModel();

  _DeliveryNote({super.key, required this.model});

  @override
  State<StatefulWidget> createState() => _DeliveryNoteState();
}

class _DeliveryNoteState extends State<_DeliveryNote> {
  final _controller = TextEditingController();
  Timer? _debounceTimer;
  var _isLoading = false;
  final FocusNode _focusNode = FocusNode();

  void refresh() {
    setState(() {});
  }

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
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          Row(children: [
            Expanded(
                child: TextField(
              focusNode: _focusNode,
              autofocus: true,
              controller: _controller,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.none,
            ))
          ]),
          Expanded(
              child: ListView.builder(
                  itemCount: widget.docModel.goods.length,
                  itemBuilder: (context, index) {
                    final g = widget.docModel.goods[index];
                    return Column(children: [
                      Row(children: [
                        Expanded(child: Text('${g.f_name}\r\n${g.f_barcode}')),
                        Container(
                            alignment: Alignment.center,
                            width: 70,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color:
                                    g.f_qty == widget.docModel.goodsCheck[g.f_barcode]
                                        ? Colors.green
                                        : g.f_qty <
                                                (widget.docModel
                                                        .goodsCheck[g.f_barcode] ??
                                                    0)
                                            ? Colors.red
                                            : Colors.black12),
                            child: Text(prefs.mdFormatDouble(g.f_qty))),
                        Styling.rowSpacingWidget(),
                        InkWell(
                            onTap: () => _setQtyOf(g.f_barcode),
                            child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.black),
                                child: Text(
                                    prefs.mdFormatDouble(g.f_qty -
                                        (widget.docModel.goodsCheck[g.f_barcode] ??
                                            0)),
                                    style:
                                        const TextStyle(color: Colors.white))))
                      ]),
                      Styling.columnSpacingWidget(),
                    ]);
                  })),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(onPressed: _addQr, icon: Icon(Icons.qr_code, size: 40))
          ])
        ],
      ),
      if (_isLoading)
        Column(children: [
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.white24,
                  child: CircularProgressIndicator()))
        ])
    ]);
  }
}
