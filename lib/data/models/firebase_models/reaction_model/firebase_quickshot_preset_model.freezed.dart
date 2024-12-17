// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_quickshot_preset_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FirebaseQuickshotPresetModel _$FirebaseQuickshotPresetModelFromJson(Map<String, dynamic> json) {
  return _FirebaseQuickshotPresetModel.fromJson(json);
}

/// @nodoc
mixin _$FirebaseQuickshotPresetModel {
  String get url => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebaseQuickshotPresetModelCopyWith<FirebaseQuickshotPresetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseQuickshotPresetModelCopyWith<$Res> {
  factory $FirebaseQuickshotPresetModelCopyWith(
          FirebaseQuickshotPresetModel value, $Res Function(FirebaseQuickshotPresetModel) then) =
      _$FirebaseQuickshotPresetModelCopyWithImpl<$Res, FirebaseQuickshotPresetModel>;
  @useResult
  $Res call({String url, @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$FirebaseQuickshotPresetModelCopyWithImpl<$Res, $Val extends FirebaseQuickshotPresetModel>
    implements $FirebaseQuickshotPresetModelCopyWith<$Res> {
  _$FirebaseQuickshotPresetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirebaseQuickshotPresetModelImplCopyWith<$Res>
    implements $FirebaseQuickshotPresetModelCopyWith<$Res> {
  factory _$$FirebaseQuickshotPresetModelImplCopyWith(
          _$FirebaseQuickshotPresetModelImpl value, $Res Function(_$FirebaseQuickshotPresetModelImpl) then) =
      __$$FirebaseQuickshotPresetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$FirebaseQuickshotPresetModelImplCopyWithImpl<$Res>
    extends _$FirebaseQuickshotPresetModelCopyWithImpl<$Res, _$FirebaseQuickshotPresetModelImpl>
    implements _$$FirebaseQuickshotPresetModelImplCopyWith<$Res> {
  __$$FirebaseQuickshotPresetModelImplCopyWithImpl(
      _$FirebaseQuickshotPresetModelImpl _value, $Res Function(_$FirebaseQuickshotPresetModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$FirebaseQuickshotPresetModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
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
class _$FirebaseQuickshotPresetModelImpl implements _FirebaseQuickshotPresetModel {
  const _$FirebaseQuickshotPresetModelImpl({required this.url, @TimestampConverter() required this.createdAt});

  factory _$FirebaseQuickshotPresetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirebaseQuickshotPresetModelImplFromJson(json);

  @override
  final String url;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FirebaseQuickshotPresetModel(url: $url, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirebaseQuickshotPresetModelImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirebaseQuickshotPresetModelImplCopyWith<_$FirebaseQuickshotPresetModelImpl> get copyWith =>
      __$$FirebaseQuickshotPresetModelImplCopyWithImpl<_$FirebaseQuickshotPresetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirebaseQuickshotPresetModelImplToJson(
      this,
    );
  }
}

abstract class _FirebaseQuickshotPresetModel implements FirebaseQuickshotPresetModel {
  const factory _FirebaseQuickshotPresetModel(
      {required final String url,
      @TimestampConverter() required final DateTime? createdAt}) = _$FirebaseQuickshotPresetModelImpl;

  factory _FirebaseQuickshotPresetModel.fromJson(Map<String, dynamic> json) =
      _$FirebaseQuickshotPresetModelImpl.fromJson;

  @override
  String get url;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FirebaseQuickshotPresetModelImplCopyWith<_$FirebaseQuickshotPresetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
