// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoodsGroup {
  int get id;
  String get name;
  int get count;

  /// Create a copy of GoodsGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GoodsGroupCopyWith<GoodsGroup> get copyWith =>
      _$GoodsGroupCopyWithImpl<GoodsGroup>(this as GoodsGroup, _$identity);

  /// Serializes this GoodsGroup to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GoodsGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, count);

  @override
  String toString() {
    return 'GoodsGroup(id: $id, name: $name, count: $count)';
  }
}

/// @nodoc
abstract mixin class $GoodsGroupCopyWith<$Res> {
  factory $GoodsGroupCopyWith(
          GoodsGroup value, $Res Function(GoodsGroup) _then) =
      _$GoodsGroupCopyWithImpl;
  @useResult
  $Res call({int id, String name, int count});
}

/// @nodoc
class _$GoodsGroupCopyWithImpl<$Res> implements $GoodsGroupCopyWith<$Res> {
  _$GoodsGroupCopyWithImpl(this._self, this._then);

  final GoodsGroup _self;
  final $Res Function(GoodsGroup) _then;

  /// Create a copy of GoodsGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? count = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GoodsGroup implements GoodsGroup {
  const _GoodsGroup(
      {required this.id, required this.name, required this.count});
  factory _GoodsGroup.fromJson(Map<String, dynamic> json) =>
      _$GoodsGroupFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int count;

  /// Create a copy of GoodsGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GoodsGroupCopyWith<_GoodsGroup> get copyWith =>
      __$GoodsGroupCopyWithImpl<_GoodsGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GoodsGroupToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GoodsGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, count);

  @override
  String toString() {
    return 'GoodsGroup(id: $id, name: $name, count: $count)';
  }
}

/// @nodoc
abstract mixin class _$GoodsGroupCopyWith<$Res>
    implements $GoodsGroupCopyWith<$Res> {
  factory _$GoodsGroupCopyWith(
          _GoodsGroup value, $Res Function(_GoodsGroup) _then) =
      __$GoodsGroupCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name, int count});
}

/// @nodoc
class __$GoodsGroupCopyWithImpl<$Res> implements _$GoodsGroupCopyWith<$Res> {
  __$GoodsGroupCopyWithImpl(this._self, this._then);

  final _GoodsGroup _self;
  final $Res Function(_GoodsGroup) _then;

  /// Create a copy of GoodsGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? count = null,
  }) {
    return _then(_GoodsGroup(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
