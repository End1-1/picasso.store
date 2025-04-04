// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Partner _$PartnerFromJson(Map<String, dynamic> json) => _Partner(
      id: (json['id'] as num).toInt(),
      taxname: json['taxname'] as String,
      tin: json['tin'] as String,
      phone: json['phone'] as String,
      contact: json['contact'] as String,
      mode: (json['mode'] as num).toInt(),
      discount: (json['discount'] as num).toDouble(),
      address: json['address'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PartnerToJson(_Partner instance) => <String, dynamic>{
      'id': instance.id,
      'taxname': instance.taxname,
      'tin': instance.tin,
      'phone': instance.phone,
      'contact': instance.contact,
      'mode': instance.mode,
      'discount': instance.discount,
      'address': instance.address,
      'name': instance.name,
    };
