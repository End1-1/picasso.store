// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Goods _$GoodsFromJson(Map<String, dynamic> json) => _Goods(
      f_id: (json['f_id'] as num).toInt(),
      uuid: json['uuid'] as String?,
      f_group_id: (json['f_group_id'] as num).toInt(),
      f_group_name: json['f_group_name'] as String,
      f_name: json['f_name'] as String,
      f_unit_name: json['f_unit_name'] as String,
      f_price1: (json['f_price1'] as num).toDouble(),
      f_price1disc: (json['f_price1disc'] as num).toDouble(),
      f_price2: (json['f_price2'] as num).toDouble(),
      f_price2disc: (json['f_price2disc'] as num).toDouble(),
      f_qty: (json['f_qty'] as num).toDouble(),
      f_barcode: json['f_barcode'] as String,
    );

Map<String, dynamic> _$GoodsToJson(_Goods instance) => <String, dynamic>{
      'f_id': instance.f_id,
      'uuid': instance.uuid,
      'f_group_id': instance.f_group_id,
      'f_group_name': instance.f_group_name,
      'f_name': instance.f_name,
      'f_unit_name': instance.f_unit_name,
      'f_price1': instance.f_price1,
      'f_price1disc': instance.f_price1disc,
      'f_price2': instance.f_price2,
      'f_price2disc': instance.f_price2disc,
      'f_qty': instance.f_qty,
      'f_barcode': instance.f_barcode,
    };
