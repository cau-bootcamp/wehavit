// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quickshot_preset_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuickshotPresetItemEntity _$QuickshotPresetItemEntityFromJson(Map<String, dynamic> json) {
  return _QuickshotPresetItemEntity.fromJson(json);
}

/// @nodoc
mixin _$QuickshotPresetItemEntity {
  String get url => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuickshotPresetItemEntityCopyWith<QuickshotPresetItemEntity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickshotPresetItemEntityCopyWith<$Res> {
  factory $QuickshotPresetItemEntityCopyWith(
          QuickshotPresetItemEntity value, $Res Function(QuickshotPresetItemEntity) then) =
      _$QuickshotPresetItemEntityCopyWithImpl<$Res, QuickshotPresetItemEntity>;
  @useResult
  $Res call({String url, String id, DateTime? createdAt});
}

/// @nodoc
class _$QuickshotPresetItemEntityCopyWithImpl<$Res, $Val extends QuickshotPresetItemEntity>
    implements $QuickshotPresetItemEntityCopyWith<$Res> {
  _$QuickshotPresetItemEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? id = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickshotPresetItemEntityImplCopyWith<$Res> implements $QuickshotPresetItemEntityCopyWith<$Res> {
  factory _$$QuickshotPresetItemEntityImplCopyWith(
          _$QuickshotPresetItemEntityImpl value, $Res Function(_$QuickshotPresetItemEntityImpl) then) =
      __$$QuickshotPresetItemEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String id, DateTime? createdAt});
}

/// @nodoc
class __$$QuickshotPresetItemEntityImplCopyWithImpl<$Res>
    extends _$QuickshotPresetItemEntityCopyWithImpl<$Res, _$QuickshotPresetItemEntityImpl>
    implements _$$QuickshotPresetItemEntityImplCopyWith<$Res> {
  __$$QuickshotPresetItemEntityImplCopyWithImpl(
      _$QuickshotPresetItemEntityImpl _value, $Res Function(_$QuickshotPresetItemEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? id = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$QuickshotPresetItemEntityImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
@TimestampConverter()
class _$QuickshotPresetItemEntityImpl implements _QuickshotPresetItemEntity {
  _$QuickshotPresetItemEntityImpl({this.url = '', this.id = '', required this.createdAt});

  factory _$QuickshotPresetItemEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickshotPresetItemEntityImplFromJson(json);

  @override
  @JsonKey()
  final String url;
  @override
  @JsonKey()
  final String id;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'QuickshotPresetItemEntity(url: $url, id: $id, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickshotPresetItemEntityImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, id, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickshotPresetItemEntityImplCopyWith<_$QuickshotPresetItemEntityImpl> get copyWith =>
      __$$QuickshotPresetItemEntityImplCopyWithImpl<_$QuickshotPresetItemEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickshotPresetItemEntityImplToJson(
      this,
    );
  }
}

abstract class _QuickshotPresetItemEntity implements QuickshotPresetItemEntity {
  factory _QuickshotPresetItemEntity({final String url, final String id, required final DateTime? createdAt}) =
      _$QuickshotPresetItemEntityImpl;

  factory _QuickshotPresetItemEntity.fromJson(Map<String, dynamic> json) = _$QuickshotPresetItemEntityImpl.fromJson;

  @override
  String get url;
  @override
  String get id;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$QuickshotPresetItemEntityImplCopyWith<_$QuickshotPresetItemEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
