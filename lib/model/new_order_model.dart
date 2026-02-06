import 'package:hive/hive.dart';
import 'package:picassostore/model/goods.dart';
import 'package:picassostore/model/partner.dart';
import 'package:picassostore/utils/prefs.dart';

@HiveType(typeId: 0)
class NewOrderModel {
  @HiveField(0)
  var id = '';
  @HiveField(1)
  var storeid = 0;
  @HiveField(2)
  var partner = Partner.empty();
  @HiveField(3)
  final List<Goods> goods = [];
  @HiveField(4)
  var comment = '';
  @HiveField(5)
  var paymentType = 3;
  @HiveField(6)
  var dateFor = DateTime.now().add(const Duration(days: 1));
  final bool openFromServer;

  NewOrderModel({required this.openFromServer}) {
    storeid = Prefs.config['store'] ?? 0;
  }

  double total() {
    double t = 0;
    for (final e in goods) {
      double price = priceOfGoods(e);
      price -= (price * (partner.discount / 100));
      t += price * e.f_qty;
    }
    return t;
  }

  double priceOfGoods(Goods g) {
    if (partner.id == 0) {
      return g.f_price1;
    }
    switch (partner.mode) {
      case 1:
        return g.f_price1disc > 0 ? g.f_price1disc : g.f_price1;
      case 2:
        return g.f_price2disc > 0 ? g.f_price2disc : g.f_price2;
    }
    return -1;
  }
}

class NewOrderModelAdapter extends TypeAdapter<NewOrderModel> {
  @override
  final int typeId = 0;

  @override
  NewOrderModel read(BinaryReader reader) {
    var model = NewOrderModel(openFromServer: false);
    model.id = reader.readString();
    model.storeid = reader.readInt();
    model.partner = reader.read() as Partner;
    model.goods.addAll((reader.read() as List).cast<Goods>());
    model.comment = reader.readString();
    model.paymentType = reader.readInt();
    model.dateFor = reader.read() as DateTime;
    return model;
  }

  @override
  void write(BinaryWriter writer, NewOrderModel obj) {
    writer.writeString(obj.id);
    writer.writeInt(obj.storeid);
    writer.write(obj.partner);
    writer.write(obj.goods);
    writer.writeString(obj.comment);
    writer.writeInt(obj.paymentType);
    writer.write(obj.dateFor);
  }
}
