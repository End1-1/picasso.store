// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Goods _$GoodsFromJson(Map<String, dynamic> json) => _Goods(
      id: (json['id'] as num).toInt(),
      uuid: json['uuid'] as String?,
      groupid: (json['groupid'] as num).toInt(),
      groupname: json['groupname'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      p1: (json['p1'] as num).toDouble(),
      p1d: (json['p1d'] as num).toDouble(),
      p2: (json['p2'] as num).toDouble(),
      p2d: (json['p2d'] as num).toDouble(),
      qty: (json['qty'] as num).toDouble(),
      sku: json['sku'] as String,
    );

Map<String, dynamic> _$GoodsToJson(_Goods instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'groupid': instance.groupid,
      'groupname': instance.groupname,
      'name': instance.name,
      'unit': instance.unit,
      'p1': instance.p1,
      'p1d': instance.p1d,
      'p2': instance.p2,
      'p2d': instance.p2d,
      'qty': instance.qty,
      'sku': instance.sku,
    };
