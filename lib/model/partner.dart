import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'partner.freezed.dart';

part 'partner.g.dart';


@HiveType(typeId: 1)
@freezed
sealed class Partner with _$Partner {
  const factory Partner(
      {@HiveField(0) required int id,
      @HiveField(1) required String taxname,
      @HiveField(2) required String tin,
      @HiveField(3) required String phone,
      @HiveField(4) required String contact,
      @HiveField(5) required int mode,
      @HiveField(6) required double discount,
      @HiveField(7) required String address}) = _Partner;

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

class PartnerAdapter extends TypeAdapter<Partner> {
  @override
  final int typeId = 1;

  @override
  Partner read(BinaryReader reader) {
    return Partner(
      id: reader.readInt(),
      taxname: reader.readString(),
      tin: reader.readString(),
      phone: reader.readString(),
      contact: reader.readString(),
      mode: reader.readInt(),
      discount: reader.readDouble(),
      address: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Partner obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.taxname);
    writer.writeString(obj.tin);
    writer.writeString(obj.phone);
    writer.writeString(obj.contact);
    writer.writeInt(obj.mode);
    writer.writeDouble(obj.discount);
    writer.writeString(obj.address);
  }
}