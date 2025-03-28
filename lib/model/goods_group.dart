import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods_group.freezed.dart';
part 'goods_group.g.dart';

@freezed
sealed class GoodsGroup with _$GoodsGroup {
  const factory GoodsGroup({
    required int id,
    required String name,
    required int count
}) = _GoodsGroup;

  factory GoodsGroup.fromJson(Map<String, dynamic> json) => _$GoodsGroupFromJson(json);
}