part of 'deliver_note.dart';

class _DocModel {
  final List<Goods> goods = [];
  final goodsCheck = <String, double>{};
  final List<String> codes = [];
  final List<String> qrCode = [];

  void count() {
    goodsCheck.clear();
    for (final q in goodsCheck.keys) {
      goodsCheck[q] = 0;
    }
    for (var e in codes) {
      goodsCheck[e] = goodsCheck[e] ?? 0 + 1;
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
          'class': 'checksaleoutput',
          'method': 'open',
          'docparams': barcode
        }).then((reply) {
          if (reply['status'] == 1) {
            widget.docModel.goods.clear();
            for (final e in reply['goods']) {
              final Goods g = Goods.fromJson(e);
              widget.docModel.goods.add(g);
              widget.docModel.goodsCheck[g.sku] = 0;
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
    final barcode = await widget.model.navigation.readBarcode();
    if (barcode != null) {
      setState(() {
        if (barcode.length == 13 || barcode.length == 8) {
          widget.docModel.codes.add(barcode);
        }
        widget.docModel.count();
      });
    }
  }
}
