import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/screen/app.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WMCheckQty extends WMApp {
  WMCheckQty({super.key, required super.model});

  @override
  String titleText() {
    return model.tr('Check quantity');
  }

  @override
  Widget body() {
    return Column(
      children: [
        Styling.columnSpacingWidget(),
        Row(
          children: [
            Expanded(
                child: Styling.textFormField(
                    model.scancodeTextController, model.tr('Barcode'),
                    onSubmit: model.searchBarcode,
                    autofocus: true,
                    focusNode: model.scancodeFocus)),
            IconButton(
                onPressed: () {
                  model.scancodeTextController.clear();
                  model.scancodeFocus.requestFocus();
                },
                icon: const Icon(Icons.clear_sharp)),
            IconButton(onPressed: model.readBarcode, icon: const Icon(Icons.qr_code))
          ],
        ),
        Styling.columnSpacingWidget(),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      model.replaceBarcodeSize("34");
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.black38))),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        child: Container(child: const Text('34')))),
                InkWell(
                    onTap: () {
                      model.replaceBarcodeSize("36");
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.black38))),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        child: Container(child: const Text('36')))),
                InkWell(
                    onTap: () {
                      model.replaceBarcodeSize("38");
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.black38))),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        child: Container(child: const Text('38')))),
                InkWell(
                    onTap: () {
                      model.replaceBarcodeSize("40");
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.black38))),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        child: Container(child: const Text('40')))),
                InkWell(
                    onTap: () {
                      model.replaceBarcodeSize("42");
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.black38))),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        child: Container(child: const Text('42')))),
                InkWell(
                    onTap: () {
                      model.replaceBarcodeSize("44");
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.black38))),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        child: Container(child: const Text('44'))))
              ],
            )),
        Styling.columnSpacingWidget(),
        BlocBuilder<AppBloc, AppState>(builder: (builder, state) {
          if (state.runtimeType == AppState) {
            return Container();
          }
          if (state is AppStateFinished) {
            if (state.data.isEmpty) {
              return Container();
            }

            return Expanded(
                child: SingleChildScrollView(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Styling.text(
                          '${state.data['goods']['f_groupname']} ${state.data['goods']['f_goodsname']}')),
                  Expanded(child: Container()),
                  Styling.text('${prefs.df(state.data['goods']['f_price1'])} ֏'),
                  IconButton(onPressed: () {model.navigation.goodsInfo(state.data['goods']);}, icon: const Icon(Icons.info_outline)),
                  Styling.rowSpacingWidget()
                ]),
                Styling.columnSpacingWidget(),
                Row(children: [
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      width: 150,
                      child: Styling.text(model.tr('Store'))),
                  Styling.rowSpacingWidget(),
                  Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          width: 50,
          child:Styling.text(model.tr('Qty'))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      width: 50,
                      child:Styling.text(model.tr('Res.')))
                ]),
                for (final e in state.data['result']) ...[
                  InkWell(
                      onTap: () {
                        model.navigation.goodsReservation(state.data, e);
                      },
                      child: Row(children: [
                        Container(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            width: 150,
                            child: Styling.text(e['f_storename'])),
                        Styling.rowSpacingWidget(),
          Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          width: 50,
          child:Styling.text('${prefs.df(e['f_qty'])}')),
                        Container(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            width: 50,
                            child:Styling.text('${prefs.df(e['f_reserve'])}'))
                      ]))
                ]
              ],
            )));
          } else {
            return Container();
          }
        })
      ],
    );
  }
}
