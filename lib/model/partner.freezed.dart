// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Partner {
  @HiveField(0)
  int get id;
  @HiveField(1)
  String get taxname;
  @HiveField(2)
  String get tin;
  @HiveField(3)
  String get phone;
  @HiveField(4)
  String get contact;
  @HiveField(5)
  int get mode;
  @HiveField(6)
  double get discount;
  @HiveField(7)
  String get address;
  @HiveField(8)
  String get name;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartnerCopyWith<Partner> get copyWith =>
      _$PartnerCopyWithImpl<Partner>(this as Partner, _$identity);

  /// Serializes this Partner to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Partner &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taxname, taxname) || other.taxname == taxname) &&
            (identical(other.tin, tin) || other.tin == tin) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, taxname, tin, phone, contact,
      mode, discount, address, name);

  @override
  String toString() {
    return 'Partner(id: $id, taxname: $taxname, tin: $tin, phone: $phone, contact: $contact, mode: $mode, discount: $discount, address: $address, name: $name)';
  }
}

/// @nodoc
abstract mixin class $PartnerCopyWith<$Res> {
  factory $PartnerCopyWith(Partner value, $Res Function(Partner) _then) =
      _$PartnerCopyWithImpl;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String taxname,
      @HiveField(2) String tin,
      @HiveField(3) String phone,
      @HiveField(4) String contact,
      @HiveField(5) int mode,
      @HiveField(6) double discount,
      @HiveField(7) String address,
      @HiveField(8) String name});
}

/// @nodoc
class _$PartnerCopyWithImpl<$Res> implements $PartnerCopyWith<$Res> {
  _$PartnerCopyWithImpl(this._self, this._then);

  final Partner _self;
  final $Res Function(Partner) _then;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taxname = null,
    Object? tin = null,
    Object? phone = null,
    Object? contact = null,
    Object? mode = null,
    Object? discount = null,
    Object? address = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      taxname: null == taxname
          ? _self.taxname
          : taxname // ignore: cast_nullable_to_non_nullable
              as String,
      tin: null == tin
          ? _self.tin
          : tin // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      contact: null == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as int,
      discount: null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Partner implements Partner {
  const _Partner(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.taxname,
      @HiveField(2) required this.tin,
      @HiveField(3) required this.phone,
      @HiveField(4) required this.contact,
      @HiveField(5) required this.mode,
      @HiveField(6) required this.discount,
      @HiveField(7) required this.address,
      @HiveField(8) required this.name});
  factory _Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);

  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String taxname;
  @override
  @HiveField(2)
  final String tin;
  @override
  @HiveField(3)
  final String phone;
  @override
  @HiveField(4)
  final String contact;
  @override
  @HiveField(5)
  final int mode;
  @override
  @HiveField(6)
  final double discount;
  @override
  @HiveField(7)
  final String address;
  @override
  @HiveField(8)
  final String name;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartnerCopyWith<_Partner> get copyWith =>
      __$PartnerCopyWithImpl<_Partner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PartnerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Partner &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taxname, taxname) || other.taxname == taxname) &&
            (identical(other.tin, tin) || other.tin == tin) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, taxname, tin, phone, contact,
      mode, discount, address, name);

  @override
  String toString() {
    return 'Partner(id: $id, taxname: $taxname, tin: $tin, phone: $phone, contact: $contact, mode: $mode, discount: $discount, address: $address, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$PartnerCopyWith<$Res> implements $PartnerCopyWith<$Res> {
  factory _$PartnerCopyWith(_Partner value, $Res Function(_Partner) _then) =
      __$PartnerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String taxname,
      @HiveField(2) String tin,
      @HiveField(3) String phone,
      @HiveField(4) String contact,
      @HiveField(5) int mode,
      @HiveField(6) double discount,
      @HiveField(7) String address,
      @HiveField(8) String name});
}

/// @nodoc
class __$PartnerCopyWithImpl<$Res> implements _$PartnerCopyWith<$Res> {
  __$PartnerCopyWithImpl(this._self, this._then);

  final _Partner _self;
  final $Res Function(_Partner) _then;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? taxname = null,
    Object? tin = null,
    Object? phone = null,
    Object? contact = null,
    Object? mode = null,
    Object? discount = null,
    Object? address = null,
    Object? name = null,
  }) {
    return _then(_Partner(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      taxname: null == taxname
          ? _self.taxname
          : taxname // ignore: cast_nullable_to_non_nullable
              as String,
      tin: null == tin
          ? _self.tin
          : tin // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      contact: null == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as int,
      discount: null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
