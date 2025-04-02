part of 'deliver_note.dart';

class _DocModel {
  final List<Goods> goods = [];
  final goodsCheck = <String, double>{};
  final List<String> codes = [];
  void count() {
    goodsCheck.clear();
    for (var e in codes) {

    }
  }
}

class GoodsCubit extends Cubit<List<Goods>> {
  GoodsCubit() : super([]);
  void data(List<Goods> goods) => emit(goods);
}

extension _DeliveryNoteExt on _DeliveryNoteState {
  void _openDoc() async {
    widget.model.navigation.readBarcode().then((barcode) {
      if (barcode != null) {
        HttpQuery('engine/picasso.store/').request({
          'class':'checksaleoutput',
          'method':'open',
          'docparams':barcode
        }).then((reply){
          if (reply['status'] == 1) {
            widget.docModel.goods.clear();
            for (final e in reply['goods']) {
              widget.docModel.goods.add(Goods.fromJson(e));
            }
            setState(() => true);
          } else {
            widget.model.error(reply['data']);
          }
        });
      }
    });
  }

  void _addQr() async {
    if (widget.docModel.goods.isEmpty) {
      widget.model.error(locale().emptyOrder);
      return;
    }
    final barcode = await  widget.model.navigation.readBarcode();
      if (barcode != null) {
        setState(() {
        widget.docModel.codes.add(barcode);
        widget.docModel.count(); });
      }
  }

}