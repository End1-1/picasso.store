part of 'goods_reserve.dart';

class GoodsReserveModel {
  final reserveQtyTextController = TextEditingController();
  final reserveCommentTextController = TextEditingController();
  var reservationExpiration = DateTime.now();
  var reservationStore = 0;
  var reservationGoods = 0;
  var reservationGoodsName = '';
  var maxReserveQty = 0.0;
}

extension WMEGoodsReserve on WMGoodsReserve {
  void createReservation() {
    var err = '';
    var qty = double.tryParse(_model.reserveQtyTextController.text) ?? 0;
    if (qty < 1) {
      err += model.tr('Quantity is not set');
      err += '\r\n';
    }
    if (err.isNotEmpty) {
      BlocProvider.of<AppBloc>(prefs.context()).add(AppEventError(err));
      return;
    }
    Map<String, dynamic> d = {
      'source': Prefs.config['store'] ?? 0,
      'store': _model.reservationStore,
      'goods': _model.reservationGoods,
      'goodsname': _model.reservationGoodsName,
      'qty': double.tryParse(_model.reserveQtyTextController.text) ?? 0,
      'message': _model.reserveCommentTextController.text,
      'enddate': prefs.dateMySqlText(_model.reservationExpiration),
    };
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        model.tr('Create reservation'), 'engine/worker/create-reservation.php', d,
            (e, s) {
          if (e) {
          } else {
            Navigator.pop(prefs.context(), true);
          }
        }, null));
  }

  void setReservationExpiration() {
    showDatePicker(
        context: prefs.context(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)))
        .then((value) {
      if (value != null) {
        _model.reservationExpiration = value;
        BlocProvider.of<DateBloc>(prefs.context()).add(DateEvent());
      }
    });
  }

  void reserveQtyChanged(String s) {
    var nv = double.tryParse(s) ?? 0;
    if (nv > _model.maxReserveQty) {
      nv = _model.maxReserveQty;
      _model.reserveQtyTextController.text = prefs.df(nv.toString());
    }
  }
}