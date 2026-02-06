// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Goods {
  @HiveField(0)
  int get f_id;
  @HiveField(1)
  String? get uuid;
  @HiveField(2)
  int get f_group_id;
  @HiveField(3)
  String get f_group_name;
  @HiveField(4)
  String get f_name;
  @HiveField(5)
  String get f_unit_name;
  @HiveField(6)
  double get f_price1;
  @HiveField(7)
  double get f_price1disc;
  @HiveField(8)
  double get f_price2;
  @HiveField(9)
  double get f_price2disc;
  @HiveField(10)
  double get f_qty;
  @HiveField(11)
  String get f_barcode;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GoodsCopyWith<Goods> get copyWith =>
      _$GoodsCopyWithImpl<Goods>(this as Goods, _$identity);

  /// Serializes this Goods to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Goods &&
            (identical(other.f_id, f_id) || other.f_id == f_id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.f_group_id, f_group_id) ||
                other.f_group_id == f_group_id) &&
            (identical(other.f_group_name, f_group_name) ||
                other.f_group_name == f_group_name) &&
            (identical(other.f_name, f_name) || other.f_name == f_name) &&
            (identical(other.f_unit_name, f_unit_name) ||
                other.f_unit_name == f_unit_name) &&
            (identical(other.f_price1, f_price1) ||
                other.f_price1 == f_price1) &&
            (identical(other.f_price1disc, f_price1disc) ||
                other.f_price1disc == f_price1disc) &&
            (identical(other.f_price2, f_price2) ||
                other.f_price2 == f_price2) &&
            (identical(other.f_price2disc, f_price2disc) ||
                other.f_price2disc == f_price2disc) &&
            (identical(other.f_qty, f_qty) || other.f_qty == f_qty) &&
            (identical(other.f_barcode, f_barcode) ||
                other.f_barcode == f_barcode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      f_id,
      uuid,
      f_group_id,
      f_group_name,
      f_name,
      f_unit_name,
      f_price1,
      f_price1disc,
      f_price2,
      f_price2disc,
      f_qty,
      f_barcode);

  @override
  String toString() {
    return 'Goods(f_id: $f_id, uuid: $uuid, f_group_id: $f_group_id, f_group_name: $f_group_name, f_name: $f_name, f_unit_name: $f_unit_name, f_price1: $f_price1, f_price1disc: $f_price1disc, f_price2: $f_price2, f_price2disc: $f_price2disc, f_qty: $f_qty, f_barcode: $f_barcode)';
  }
}

/// @nodoc
abstract mixin class $GoodsCopyWith<$Res> {
  factory $GoodsCopyWith(Goods value, $Res Function(Goods) _then) =
      _$GoodsCopyWithImpl;
  @useResult
  $Res call(
      {@HiveField(0) int f_id,
      @HiveField(1) String? uuid,
      @HiveField(2) int f_group_id,
      @HiveField(3) String f_group_name,
      @HiveField(4) String f_name,
      @HiveField(5) String f_unit_name,
      @HiveField(6) double f_price1,
      @HiveField(7) double f_price1disc,
      @HiveField(8) double f_price2,
      @HiveField(9) double f_price2disc,
      @HiveField(10) double f_qty,
      @HiveField(11) String f_barcode});
}

/// @nodoc
class _$GoodsCopyWithImpl<$Res> implements $GoodsCopyWith<$Res> {
  _$GoodsCopyWithImpl(this._self, this._then);

  final Goods _self;
  final $Res Function(Goods) _then;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? f_id = null,
    Object? uuid = freezed,
    Object? f_group_id = null,
    Object? f_group_name = null,
    Object? f_name = null,
    Object? f_unit_name = null,
    Object? f_price1 = null,
    Object? f_price1disc = null,
    Object? f_price2 = null,
    Object? f_price2disc = null,
    Object? f_qty = null,
    Object? f_barcode = null,
  }) {
    return _then(_self.copyWith(
      f_id: null == f_id
          ? _self.f_id
          : f_id // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: freezed == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      f_group_id: null == f_group_id
          ? _self.f_group_id
          : f_group_id // ignore: cast_nullable_to_non_nullable
              as int,
      f_group_name: null == f_group_name
          ? _self.f_group_name
          : f_group_name // ignore: cast_nullable_to_non_nullable
              as String,
      f_name: null == f_name
          ? _self.f_name
          : f_name // ignore: cast_nullable_to_non_nullable
              as String,
      f_unit_name: null == f_unit_name
          ? _self.f_unit_name
          : f_unit_name // ignore: cast_nullable_to_non_nullable
              as String,
      f_price1: null == f_price1
          ? _self.f_price1
          : f_price1 // ignore: cast_nullable_to_non_nullable
              as double,
      f_price1disc: null == f_price1disc
          ? _self.f_price1disc
          : f_price1disc // ignore: cast_nullable_to_non_nullable
              as double,
      f_price2: null == f_price2
          ? _self.f_price2
          : f_price2 // ignore: cast_nullable_to_non_nullable
              as double,
      f_price2disc: null == f_price2disc
          ? _self.f_price2disc
          : f_price2disc // ignore: cast_nullable_to_non_nullable
              as double,
      f_qty: null == f_qty
          ? _self.f_qty
          : f_qty // ignore: cast_nullable_to_non_nullable
              as double,
      f_barcode: null == f_barcode
          ? _self.f_barcode
          : f_barcode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Goods implements Goods {
  const _Goods(
      {@HiveField(0) required this.f_id,
      @HiveField(1) required this.uuid,
      @HiveField(2) required this.f_group_id,
      @HiveField(3) required this.f_group_name,
      @HiveField(4) required this.f_name,
      @HiveField(5) required this.f_unit_name,
      @HiveField(6) required this.f_price1,
      @HiveField(7) required this.f_price1disc,
      @HiveField(8) required this.f_price2,
      @HiveField(9) required this.f_price2disc,
      @HiveField(10) required this.f_qty,
      @HiveField(11) required this.f_barcode});
  factory _Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);

  @override
  @HiveField(0)
  final int f_id;
  @override
  @HiveField(1)
  final String? uuid;
  @override
  @HiveField(2)
  final int f_group_id;
  @override
  @HiveField(3)
  final String f_group_name;
  @override
  @HiveField(4)
  final String f_name;
  @override
  @HiveField(5)
  final String f_unit_name;
  @override
  @HiveField(6)
  final double f_price1;
  @override
  @HiveField(7)
  final double f_price1disc;
  @override
  @HiveField(8)
  final double f_price2;
  @override
  @HiveField(9)
  final double f_price2disc;
  @override
  @HiveField(10)
  final double f_qty;
  @override
  @HiveField(11)
  final String f_barcode;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GoodsCopyWith<_Goods> get copyWith =>
      __$GoodsCopyWithImpl<_Goods>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GoodsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Goods &&
            (identical(other.f_id, f_id) || other.f_id == f_id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.f_group_id, f_group_id) ||
                other.f_group_id == f_group_id) &&
            (identical(other.f_group_name, f_group_name) ||
                other.f_group_name == f_group_name) &&
            (identical(other.f_name, f_name) || other.f_name == f_name) &&
            (identical(other.f_unit_name, f_unit_name) ||
                other.f_unit_name == f_unit_name) &&
            (identical(other.f_price1, f_price1) ||
                other.f_price1 == f_price1) &&
            (identical(other.f_price1disc, f_price1disc) ||
                other.f_price1disc == f_price1disc) &&
            (identical(other.f_price2, f_price2) ||
                other.f_price2 == f_price2) &&
            (identical(other.f_price2disc, f_price2disc) ||
                other.f_price2disc == f_price2disc) &&
            (identical(other.f_qty, f_qty) || other.f_qty == f_qty) &&
            (identical(other.f_barcode, f_barcode) ||
                other.f_barcode == f_barcode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      f_id,
      uuid,
      f_group_id,
      f_group_name,
      f_name,
      f_unit_name,
      f_price1,
      f_price1disc,
      f_price2,
      f_price2disc,
      f_qty,
      f_barcode);

  @override
  String toString() {
    return 'Goods(f_id: $f_id, uuid: $uuid, f_group_id: $f_group_id, f_group_name: $f_group_name, f_name: $f_name, f_unit_name: $f_unit_name, f_price1: $f_price1, f_price1disc: $f_price1disc, f_price2: $f_price2, f_price2disc: $f_price2disc, f_qty: $f_qty, f_barcode: $f_barcode)';
  }
}

/// @nodoc
abstract mixin class _$GoodsCopyWith<$Res> implements $GoodsCopyWith<$Res> {
  factory _$GoodsCopyWith(_Goods value, $Res Function(_Goods) _then) =
      __$GoodsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int f_id,
      @HiveField(1) String? uuid,
      @HiveField(2) int f_group_id,
      @HiveField(3) String f_group_name,
      @HiveField(4) String f_name,
      @HiveField(5) String f_unit_name,
      @HiveField(6) double f_price1,
      @HiveField(7) double f_price1disc,
      @HiveField(8) double f_price2,
      @HiveField(9) double f_price2disc,
      @HiveField(10) double f_qty,
      @HiveField(11) String f_barcode});
}

/// @nodoc
class __$GoodsCopyWithImpl<$Res> implements _$GoodsCopyWith<$Res> {
  __$GoodsCopyWithImpl(this._self, this._then);

  final _Goods _self;
  final $Res Function(_Goods) _then;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? f_id = null,
    Object? uuid = freezed,
    Object? f_group_id = null,
    Object? f_group_name = null,
    Object? f_name = null,
    Object? f_unit_name = null,
    Object? f_price1 = null,
    Object? f_price1disc = null,
    Object? f_price2 = null,
    Object? f_price2disc = null,
    Object? f_qty = null,
    Object? f_barcode = null,
  }) {
    return _then(_Goods(
      f_id: null == f_id
          ? _self.f_id
          : f_id // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: freezed == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      f_group_id: null == f_group_id
          ? _self.f_group_id
          : f_group_id // ignore: cast_nullable_to_non_nullable
              as int,
      f_group_name: null == f_group_name
          ? _self.f_group_name
          : f_group_name // ignore: cast_nullable_to_non_nullable
              as String,
      f_name: null == f_name
          ? _self.f_name
          : f_name // ignore: cast_nullable_to_non_nullable
              as String,
      f_unit_name: null == f_unit_name
          ? _self.f_unit_name
          : f_unit_name // ignore: cast_nullable_to_non_nullable
              as String,
      f_price1: null == f_price1
          ? _self.f_price1
          : f_price1 // ignore: cast_nullable_to_non_nullable
              as double,
      f_price1disc: null == f_price1disc
          ? _self.f_price1disc
          : f_price1disc // ignore: cast_nullable_to_non_nullable
              as double,
      f_price2: null == f_price2
          ? _self.f_price2
          : f_price2 // ignore: cast_nullable_to_non_nullable
              as double,
      f_price2disc: null == f_price2disc
          ? _self.f_price2disc
          : f_price2disc // ignore: cast_nullable_to_non_nullable
              as double,
      f_qty: null == f_qty
          ? _self.f_qty
          : f_qty // ignore: cast_nullable_to_non_nullable
              as double,
      f_barcode: null == f_barcode
          ? _self.f_barcode
          : f_barcode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
