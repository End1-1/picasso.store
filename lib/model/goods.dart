import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'goods.freezed.dart';
part 'goods.g.dart';

@HiveType(typeId: 2)
@freezed
sealed class Goods with _$Goods {

  const factory Goods({
    @HiveField(0)required int id,
    @HiveField(1)required String? uuid,
    @HiveField(2)required int groupid,
    @HiveField(3)required String groupname,
    @HiveField(4)required String name,
    @HiveField(5)required String unit,
    @HiveField(6)required double p1,
    @HiveField(7)required double p1d,
    @HiveField(8)required double p2,
    @HiveField(9)required double p2d,
    @HiveField(10)required double qty,
    @HiveField(11) required String sku
}) = _Goods;

  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);

}

class GoodsAdapter extends TypeAdapter<Goods> {
  @override
  final int typeId = 2;

  @override
  Goods read(BinaryReader reader) {
    return Goods(
      id: reader.readInt(),
      uuid: reader.readString(),
      groupid: reader.readInt(),
      groupname: reader.readString(),
      name: reader.readString(),
      unit: reader.readString(),
      p1: reader.readDouble(),
      p1d: reader.readDouble(),
      p2: reader.readDouble(),
      p2d: reader.readDouble(),
      qty: reader.readDouble(),
      sku: reader.readString()
    );
  }

  @override
  void write(BinaryWriter writer, Goods obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.uuid ?? '');
    writer.writeInt(obj.groupid);
    writer.writeString(obj.groupname);
    writer.writeString(obj.name);
    writer.writeString(obj.unit);
    writer.writeDouble(obj.p1);
    writer.writeDouble(obj.p1d);
    writer.writeDouble(obj.p2);
    writer.writeDouble(obj.p2d);
    writer.writeDouble(obj.qty);
    writer.writeString(obj.sku);
  }
}