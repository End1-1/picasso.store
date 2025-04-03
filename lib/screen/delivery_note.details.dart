import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/utils/http_query.dart';

import '../utils/prefs.dart';
import 'delivery_note.model.dart';

class DeliveryNoteDetails extends WMApp {
  final DocModel docModel;
  final String barcode;

  DeliveryNoteDetails(this.docModel, this.barcode,
      {super.key, required super.model});

  @override
  Widget body(BuildContext context) {
    return _DeliveryNoteDetails(docModel, barcode, model);
  }
}

class _DeliveryNoteDetails extends StatefulWidget {
  final WMModel model;
  final DocModel docModel;
  final String barcode;

  const _DeliveryNoteDetails(this.docModel, this.barcode, this.model);

  @override
  State<StatefulWidget> createState() => _DeliveryNoteDetailsState();
}

class _DeliveryNoteDetailsState extends State<_DeliveryNoteDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
              child: OutlinedButton(
                  onPressed: () => widget.docModel.setOk(widget.barcode),
                  child: Text(locale().setOk))),
          Expanded(
              child: OutlinedButton(
                  onPressed: () => widget.docModel.setNotOk(widget.barcode),
                  child: Text(locale().setNotOk))),
        ]),
        Expanded(
            child: ListView.builder(
                itemCount: widget.docModel.qrCode.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(child: Text(widget.docModel.qrCode[index])),
                      IconButton(
                          onPressed: () => _removeRow(index),
                          icon: Icon(Icons.delete_forever))
                    ],
                  );
                }))
      ],
    );
  }

  void _removeRow(int index) {
    final qr = widget.docModel.qrCode[index];
    HttpQuery('engine/picasso.store/').request({
      'class': 'checksaleoutput',
      'method': 'removeQr',
      'f_header': widget.docModel.id,
      'f_qr': base64Encode(qr.codeUnits)
    }).then((reply) {
      if (reply['status']==1) {
      widget.docModel.qrCode.removeAt(index);
      if ((widget.docModel.goodsCheck[widget.barcode] ?? 0) > 0) {
        widget.docModel.goodsCheck[widget.barcode] =
            widget.docModel.goodsCheck[widget.barcode]! - 1;
      }} else {
        widget.model.error(reply['data']);
      }
      setState(() {

      });
    });
  }
}
