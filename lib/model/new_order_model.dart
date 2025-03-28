import 'package:picassostore/model/goods.dart';
import 'package:picassostore/model/partner.dart';
import 'package:picassostore/utils/prefs.dart';

class NewOrderModel {
  var id = '';
  var storeid = 0;
  var partner = Partner.empty();
  final List<Goods> goods = [];
  var comment = '';
  var paymentType = 3;
  var dateFor = DateTime.now().add(const Duration(days: 1));

  NewOrderModel() {
    storeid = Prefs.config['store'] ?? 0;
  }

  double total() {
    double t = 0;
    for (final e in goods) {
      double price = priceOfGoods(e);
      price -= (price * partner.discount);
      t += price * e.qty;
    }
    return t;
  }

  double priceOfGoods(Goods g) {
    if (partner.id == 0) {
      return g.p1;
    }
    switch (partner.mode) {
      case 1:
        return g.p1d > 0 ? g.p1d : g.p1;
      case 2:
        return g.p2d > 0 ? g.p2d : g.p2;
    }
    return -1;
  }
}