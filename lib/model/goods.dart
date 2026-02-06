import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'goods.freezed.dart';
part 'goods.g.dart';

@HiveType(typeId: 2)
@freezed
sealed class Goods with _$Goods {

  const factory Goods({
    @HiveField(0)required int f_id,
    @HiveField(1)required String? uuid,
    @HiveField(2)required int f_group_id,
    @HiveField(3)required String f_group_name,
    @HiveField(4)required String f_name,
    @HiveField(5)required String f_unit_name,
    @HiveField(6)required double f_price1,
    @HiveField(7)required double f_price1disc,
    @HiveField(8)required double f_price2,
    @HiveField(9)required double f_price2disc,
    @HiveField(10)required double f_qty,
    @HiveField(11) required String f_barcode
}) = _Goods;

  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);

}

class GoodsAdapter extends TypeAdapter<Goods> {
  @override
  final int typeId = 2;

  @override
  Goods read(BinaryReader reader) {
    return Goods(
      f_id: reader.readInt(),
      uuid: reader.readString(),
      f_group_id: reader.readInt(),
      f_group_name: reader.readString(),
      f_name: reader.readString(),
      f_unit_name: reader.readString(),
      f_price1: reader.readDouble(),
      f_price1disc: reader.readDouble(),
      f_price2: reader.readDouble(),
      f_price2disc: reader.readDouble(),
      f_qty: reader.readDouble(),
      f_barcode: reader.readString()
    );
  }

  @override
  void write(BinaryWriter writer, Goods obj) {
    writer.writeInt(obj.f_id);
    writer.writeString(obj.uuid ?? '');
    writer.writeInt(obj.f_group_id);
    writer.writeString(obj.f_group_name);
    writer.writeString(obj.f_name);
    writer.writeString(obj.f_unit_name);
    writer.writeDouble(obj.f_price1);
    writer.writeDouble(obj.f_price1disc);
    writer.writeDouble(obj.f_price2);
    writer.writeDouble(obj.f_price2disc);
    writer.writeDouble(obj.f_qty);
    writer.writeString(obj.f_barcode);
  }
}