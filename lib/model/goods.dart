import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods.freezed.dart';
part 'goods.g.dart';

@freezed
sealed class Goods with _$Goods {

  const factory Goods({
    required int id,
    required String? uuid,
    required int groupid,
    required String groupname,
    required String name,
    required String unit,
    required double p1,
    required double p1d,
    required double p2,
    required double p2d,
    required double qty
}) = _Goods;

  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);

}