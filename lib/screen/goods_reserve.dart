import 'package:cafe5_mworker/bloc/date_bloc.dart';
import 'package:cafe5_mworker/screen/app.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WMGoodsReserve extends WMApp {
  final Map<String, dynamic> info;
  final Map<String, dynamic> store;

  WMGoodsReserve(this.info, this.store, {super.key, required super.model}) {
    model.reservationStore = store['f_store'];
    model.reservationGoods = info['goods']['f_id'];
    model.reservationGoodsName = info['goods']['f_goodsname'];
    model.maxReserveQty = (double.tryParse(store['f_qty']) ?? 0) -
        (double.tryParse(store['f_reserve']) ?? 0);
  }

  @override
  String titleText() {
    return model.tr('Reservation');
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(
          onPressed: model.createReservation, icon: const Icon(Icons.save_outlined))
    ];
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Styling.text(info['goods']['f_groupname']),
              Styling.rowSpacingWidget(),
              Styling.text(info['goods']['f_goodsname'])
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Styling.text(info['goods']['f_scancode']),
            ],
          ),
          Styling.columnSpacingWidget(),
          Row(
            children: [
              Styling.text(model.tr('Reservation data')),
              Expanded(child: Container()),
              Styling.text(prefs.currentDateText())
            ],
          ),
          Styling.columnSpacingWidget(),
          Row(
            children: [
              Styling.text(model.tr('Reservation expiration')),
              Expanded(child: Container()),
              BlocBuilder<DateBloc, DateState>(builder: (builder, state) {
                return InkWell(
                    onTap: model.setReservationExpiration,
                    child: Styling.text(
                        prefs.dateText(model.reservationExpiration)));
              })
            ],
          ),
          Styling.columnSpacingWidget(),
          Row(
            children: [
              Styling.text(model.tr('Store')),
              Expanded(child: Container()),
              Styling.text(store['f_storename'])
            ],
          ),
          Styling.columnSpacingWidget(),
          Row(
            children: [
              Styling.text(model.tr('Available quantity')),
              Expanded(child: Container()),
              Styling.text(prefs.df('${model.maxReserveQty}'))
            ],
          ),
          Styling.columnSpacingWidget(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Styling.text(model.tr('Quantity')),
              Expanded(child: Container()),
              SizedBox(
                  width: 50,
                  child: TextFormField(
                    onChanged: model.reserveQtyChanged,
                    textAlign: TextAlign.right,
                    controller: model.reserveQtyTextController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ))
            ],
          ),
          Styling.columnSpacingWidget(),
          Styling.textFormField(
              model.reserveCommentTextController, model.tr('Comment'),
              maxLines: 5)
        ],
      ),
    );
  }
}
