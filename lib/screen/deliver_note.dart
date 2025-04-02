import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/model/goods.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/utils/http_query.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/styles.dart';

part 'delivery_note.model.dart';

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
          onPressed: _deliveryNoteState.currentState?._openDoc,
          icon: Icon(Icons.file_open_outlined))
    ];
  }

  @override
  Widget body(BuildContext context) {
    return _DeliveryNote(key: _deliveryNoteState, model: model);
  }
}

class _DeliveryNote extends StatefulWidget {
  final WMModel model;
  final docModel = _DocModel();

  _DeliveryNote({super.key, required this.model});

  @override
  State<StatefulWidget> createState() => _DeliveryNoteState();
}

class _DeliveryNoteState extends State<_DeliveryNote> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(

                itemCount: widget.docModel.goods.length,
                itemBuilder: (context, index) {
                  final g = widget.docModel.goods[index];
                  return Column(children: [Row(children: [
                    Expanded(child: Text(g.name)),
                    Container(
                      padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: g.qty == widget.docModel.goodsCheck[g.sku]
                                ? Colors.green
                                : Colors.black12),
                        child: Text(prefs.mdFormatDouble(g.qty))),
                    Styling.rowSpacingWidget(),
                    Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.black),
                        child: Text(prefs.mdFormatDouble(g.qty - (widget.docModel.goodsCheck[g.sku] ?? 0)), style: const TextStyle(color: Colors.white)))
                  ]),
                    Styling.columnSpacingWidget(),
                  ]);
                })),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(onPressed: _addQr, icon: Icon(Icons.qr_code, size: 40))
        ])
      ],
    );
  }
}
