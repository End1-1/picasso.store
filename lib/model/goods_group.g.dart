// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoodsGroup _$GoodsGroupFromJson(Map<String, dynamic> json) => _GoodsGroup(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$GoodsGroupToJson(_GoodsGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };
