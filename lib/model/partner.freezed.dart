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
  int get id;
  String get taxname;
  String get tin;
  String get phone;
  String get contact;
  int get mode;
  double get discount;
  String get address;

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
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, taxname, tin, phone, contact, mode, discount, address);

  @override
  String toString() {
    return 'Partner(id: $id, taxname: $taxname, tin: $tin, phone: $phone, contact: $contact, mode: $mode, discount: $discount, address: $address)';
  }
}

/// @nodoc
abstract mixin class $PartnerCopyWith<$Res> {
  factory $PartnerCopyWith(Partner value, $Res Function(Partner) _then) =
      _$PartnerCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String taxname,
      String tin,
      String phone,
      String contact,
      int mode,
      double discount,
      String address});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Partner implements Partner {
  const _Partner(
      {required this.id,
      required this.taxname,
      required this.tin,
      required this.phone,
      required this.contact,
      required this.mode,
      required this.discount,
      required this.address});
  factory _Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);

  @override
  final int id;
  @override
  final String taxname;
  @override
  final String tin;
  @override
  final String phone;
  @override
  final String contact;
  @override
  final int mode;
  @override
  final double discount;
  @override
  final String address;

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
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, taxname, tin, phone, contact, mode, discount, address);

  @override
  String toString() {
    return 'Partner(id: $id, taxname: $taxname, tin: $tin, phone: $phone, contact: $contact, mode: $mode, discount: $discount, address: $address)';
  }
}

/// @nodoc
abstract mixin class _$PartnerCopyWith<$Res> implements $PartnerCopyWith<$Res> {
  factory _$PartnerCopyWith(_Partner value, $Res Function(_Partner) _then) =
      __$PartnerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String taxname,
      String tin,
      String phone,
      String contact,
      int mode,
      double discount,
      String address});
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
    ));
  }
}

// dart format on
