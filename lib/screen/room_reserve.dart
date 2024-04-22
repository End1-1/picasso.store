import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/screen/app.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/ios.dart';

part 'room_reserve.model.dart';

class WMRoomReserve extends WMApp {
  final _model = RoomReserveModel();

  WMRoomReserve({super.key, required super.model, dynamic room}) {
    _model.room = room;
    openRoom();
  }

  @override
  String titleText() {
    return _model.room['f_short'];
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(onPressed: save, icon: Icon(Icons.save_outlined))
    ];
  }

  @override
  Widget body() {
    return BlocBuilder<AppBloc, AppState>(builder: (builder, state) {
      return SingleChildScrollView(child: reserve());
    });
  }

  Widget reserve() {
    return Column(children: [
      Row(children: [
        Expanded(
            child: Styling.textCenter(model.tr('Reservation').toUpperCase()))
      ]),
      Row(children: [
        Styling.rowSpacingWidget(),
        Styling.text(model.tr('Created')),
        Expanded(child: Container()),
        Styling.rowSpacingWidget(),
        Styling.text(prefs.dateText(_model.createdDate)),
        Styling.rowSpacingWidget(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
        Styling.rowSpacingWidget(),
      ]),
      Row(children: [
        Styling.rowSpacingWidget(),
        Styling.text(model.tr('Entry')),
        Expanded(child: Container()),
        Styling.rowSpacingWidget(),
        Styling.text(prefs.dateText(_model.entryDate)),
        IconButton(onPressed: editEntry, icon: const Icon(Icons.edit)),
        Styling.rowSpacingWidget(),
      ]),
      Row(children: [
        Styling.rowSpacingWidget(),
        Styling.text(model.tr('Departure')),
        Expanded(child: Container()),
        Styling.rowSpacingWidget(),
        Styling.text(prefs.dateText(_model.departureDate)),
        IconButton(onPressed: editDeparture, icon: const Icon(Icons.edit)),
        Styling.rowSpacingWidget(),
      ]),
      Row(children: [
        Styling.rowSpacingWidget(),
        Styling.text(model.tr('Price')),
        Expanded(child: Container()),
        SizedBox(
            width: 150,
            child: Styling.textFormFieldNumbers(_model.priceTextController, '', onChange: priceChanged))
      ]),
      Styling.columnSpacingWidget(),
      Row(children: [
        Styling.rowSpacingWidget(),
        Styling.text(model.tr('Total')),
        Expanded(child: Container()),
        SizedBox(
            width: 150,
            child: Styling.textFormFieldNumbers(_model.totalTextController, '',
                readOnly: true))
      ]),
      Styling.columnSpacingWidget(),
      Row(children: [
        Expanded(child: Styling.textFormField(_model.remarksTextController, model.tr('Remarks'), maxLines: 4)),
      ]),
      Divider(),
      Row(children: [
        Expanded(child: Styling.textCenter(model.tr('Guests').toUpperCase()))
      ]),
      for (int i = 0; i < _model.guests.length; i++) ...[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20, child: Styling.text('${i + 1}')),
            SizedBox(
                width: 150,
                child: Styling.text(_model.guests[i]['f_lastname'])),
            SizedBox(
                width: 150,
                child: Styling.text(_model.guests[i]['f_firstname'])),
          ],
        )
      ],
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: addGuest, icon: Icon(Icons.add_box_outlined))
          ]),
      Divider(),
      Row(children: [
        Expanded(child: Styling.textCenter(model.tr('Folio').toUpperCase()))
      ]),
    ]);
  }
}
