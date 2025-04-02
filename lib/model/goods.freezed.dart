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
  int get id;
  @HiveField(1)
  String? get uuid;
  @HiveField(2)
  int get groupid;
  @HiveField(3)
  String get groupname;
  @HiveField(4)
  String get name;
  @HiveField(5)
  String get unit;
  @HiveField(6)
  double get p1;
  @HiveField(7)
  double get p1d;
  @HiveField(8)
  double get p2;
  @HiveField(9)
  double get p2d;
  @HiveField(10)
  double get qty;
  @HiveField(11)
  String get sku;

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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.groupid, groupid) || other.groupid == groupid) &&
            (identical(other.groupname, groupname) ||
                other.groupname == groupname) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.p1, p1) || other.p1 == p1) &&
            (identical(other.p1d, p1d) || other.p1d == p1d) &&
            (identical(other.p2, p2) || other.p2 == p2) &&
            (identical(other.p2d, p2d) || other.p2d == p2d) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.sku, sku) || other.sku == sku));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uuid, groupid, groupname,
      name, unit, p1, p1d, p2, p2d, qty, sku);

  @override
  String toString() {
    return 'Goods(id: $id, uuid: $uuid, groupid: $groupid, groupname: $groupname, name: $name, unit: $unit, p1: $p1, p1d: $p1d, p2: $p2, p2d: $p2d, qty: $qty, sku: $sku)';
  }
}

/// @nodoc
abstract mixin class $GoodsCopyWith<$Res> {
  factory $GoodsCopyWith(Goods value, $Res Function(Goods) _then) =
      _$GoodsCopyWithImpl;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String? uuid,
      @HiveField(2) int groupid,
      @HiveField(3) String groupname,
      @HiveField(4) String name,
      @HiveField(5) String unit,
      @HiveField(6) double p1,
      @HiveField(7) double p1d,
      @HiveField(8) double p2,
      @HiveField(9) double p2d,
      @HiveField(10) double qty,
      @HiveField(11) String sku});
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
    Object? id = null,
    Object? uuid = freezed,
    Object? groupid = null,
    Object? groupname = null,
    Object? name = null,
    Object? unit = null,
    Object? p1 = null,
    Object? p1d = null,
    Object? p2 = null,
    Object? p2d = null,
    Object? qty = null,
    Object? sku = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: freezed == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      groupid: null == groupid
          ? _self.groupid
          : groupid // ignore: cast_nullable_to_non_nullable
              as int,
      groupname: null == groupname
          ? _self.groupname
          : groupname // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      p1: null == p1
          ? _self.p1
          : p1 // ignore: cast_nullable_to_non_nullable
              as double,
      p1d: null == p1d
          ? _self.p1d
          : p1d // ignore: cast_nullable_to_non_nullable
              as double,
      p2: null == p2
          ? _self.p2
          : p2 // ignore: cast_nullable_to_non_nullable
              as double,
      p2d: null == p2d
          ? _self.p2d
          : p2d // ignore: cast_nullable_to_non_nullable
              as double,
      qty: null == qty
          ? _self.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as double,
      sku: null == sku
          ? _self.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Goods implements Goods {
  const _Goods(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.uuid,
      @HiveField(2) required this.groupid,
      @HiveField(3) required this.groupname,
      @HiveField(4) required this.name,
      @HiveField(5) required this.unit,
      @HiveField(6) required this.p1,
      @HiveField(7) required this.p1d,
      @HiveField(8) required this.p2,
      @HiveField(9) required this.p2d,
      @HiveField(10) required this.qty,
      @HiveField(11) required this.sku});
  factory _Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);

  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String? uuid;
  @override
  @HiveField(2)
  final int groupid;
  @override
  @HiveField(3)
  final String groupname;
  @override
  @HiveField(4)
  final String name;
  @override
  @HiveField(5)
  final String unit;
  @override
  @HiveField(6)
  final double p1;
  @override
  @HiveField(7)
  final double p1d;
  @override
  @HiveField(8)
  final double p2;
  @override
  @HiveField(9)
  final double p2d;
  @override
  @HiveField(10)
  final double qty;
  @override
  @HiveField(11)
  final String sku;

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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.groupid, groupid) || other.groupid == groupid) &&
            (identical(other.groupname, groupname) ||
                other.groupname == groupname) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.p1, p1) || other.p1 == p1) &&
            (identical(other.p1d, p1d) || other.p1d == p1d) &&
            (identical(other.p2, p2) || other.p2 == p2) &&
            (identical(other.p2d, p2d) || other.p2d == p2d) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.sku, sku) || other.sku == sku));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uuid, groupid, groupname,
      name, unit, p1, p1d, p2, p2d, qty, sku);

  @override
  String toString() {
    return 'Goods(id: $id, uuid: $uuid, groupid: $groupid, groupname: $groupname, name: $name, unit: $unit, p1: $p1, p1d: $p1d, p2: $p2, p2d: $p2d, qty: $qty, sku: $sku)';
  }
}

/// @nodoc
abstract mixin class _$GoodsCopyWith<$Res> implements $GoodsCopyWith<$Res> {
  factory _$GoodsCopyWith(_Goods value, $Res Function(_Goods) _then) =
      __$GoodsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String? uuid,
      @HiveField(2) int groupid,
      @HiveField(3) String groupname,
      @HiveField(4) String name,
      @HiveField(5) String unit,
      @HiveField(6) double p1,
      @HiveField(7) double p1d,
      @HiveField(8) double p2,
      @HiveField(9) double p2d,
      @HiveField(10) double qty,
      @HiveField(11) String sku});
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
    Object? id = null,
    Object? uuid = freezed,
    Object? groupid = null,
    Object? groupname = null,
    Object? name = null,
    Object? unit = null,
    Object? p1 = null,
    Object? p1d = null,
    Object? p2 = null,
    Object? p2d = null,
    Object? qty = null,
    Object? sku = null,
  }) {
    return _then(_Goods(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: freezed == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      groupid: null == groupid
          ? _self.groupid
          : groupid // ignore: cast_nullable_to_non_nullable
              as int,
      groupname: null == groupname
          ? _self.groupname
          : groupname // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      p1: null == p1
          ? _self.p1
          : p1 // ignore: cast_nullable_to_non_nullable
              as double,
      p1d: null == p1d
          ? _self.p1d
          : p1d // ignore: cast_nullable_to_non_nullable
              as double,
      p2: null == p2
          ? _self.p2
          : p2 // ignore: cast_nullable_to_non_nullable
              as double,
      p2d: null == p2d
          ? _self.p2d
          : p2d // ignore: cast_nullable_to_non_nullable
              as double,
      qty: null == qty
          ? _self.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as double,
      sku: null == sku
          ? _self.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
