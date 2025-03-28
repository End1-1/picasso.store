import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner.freezed.dart';
part 'partner.g.dart';

@freezed
sealed class Partner with _$Partner {
  const factory Partner(
      {required int id,
      required String taxname,
      required String tin,
      required String phone,
      required String contact,
      required int mode,
      required double discount,
      required String address}) = _Partner;

  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);

  factory Partner.empty() => Partner(
      id: 0,
      taxname: '',
      tin: '',
      phone: '',
      contact: '',
      mode: 0,
      discount: 0,
      address: '');
}
