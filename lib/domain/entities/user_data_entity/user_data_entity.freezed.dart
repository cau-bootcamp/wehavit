// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDataEntity _$UserDataEntityFromJson(Map<String, dynamic> json) {
  return _UserDataEntity.fromJson(json);
}

/// @nodoc
mixin _$UserDataEntity {
  String? get friendEmail => throw _privateConstructorUsedError;
  String? get friendId => throw _privateConstructorUsedError;
  String? get friendName => throw _privateConstructorUsedError;
  String? get friendImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataEntityCopyWith<UserDataEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataEntityCopyWith<$Res> {
  factory $UserDataEntityCopyWith(
          UserDataEntity value, $Res Function(UserDataEntity) then) =
      _$UserDataEntityCopyWithImpl<$Res, UserDataEntity>;
  @useResult
  $Res call(
      {String? friendEmail,
      String? friendId,
      String? friendName,
      String? friendImageUrl});
}

/// @nodoc
class _$UserDataEntityCopyWithImpl<$Res, $Val extends UserDataEntity>
    implements $UserDataEntityCopyWith<$Res> {
  _$UserDataEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendEmail = freezed,
    Object? friendId = freezed,
    Object? friendName = freezed,
    Object? friendImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      friendEmail: freezed == friendEmail
          ? _value.friendEmail
          : friendEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      friendId: freezed == friendId
          ? _value.friendId
          : friendId // ignore: cast_nullable_to_non_nullable
              as String?,
      friendName: freezed == friendName
          ? _value.friendName
          : friendName // ignore: cast_nullable_to_non_nullable
              as String?,
      friendImageUrl: freezed == friendImageUrl
          ? _value.friendImageUrl
          : friendImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataEntityImplCopyWith<$Res>
    implements $UserDataEntityCopyWith<$Res> {
  factory _$$UserDataEntityImplCopyWith(_$UserDataEntityImpl value,
          $Res Function(_$UserDataEntityImpl) then) =
      __$$UserDataEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? friendEmail,
      String? friendId,
      String? friendName,
      String? friendImageUrl});
}

/// @nodoc
class __$$UserDataEntityImplCopyWithImpl<$Res>
    extends _$UserDataEntityCopyWithImpl<$Res, _$UserDataEntityImpl>
    implements _$$UserDataEntityImplCopyWith<$Res> {
  __$$UserDataEntityImplCopyWithImpl(
      _$UserDataEntityImpl _value, $Res Function(_$UserDataEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendEmail = freezed,
    Object? friendId = freezed,
    Object? friendName = freezed,
    Object? friendImageUrl = freezed,
  }) {
    return _then(_$UserDataEntityImpl(
      friendEmail: freezed == friendEmail
          ? _value.friendEmail
          : friendEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      friendId: freezed == friendId
          ? _value.friendId
          : friendId // ignore: cast_nullable_to_non_nullable
              as String?,
      friendName: freezed == friendName
          ? _value.friendName
          : friendName // ignore: cast_nullable_to_non_nullable
              as String?,
      friendImageUrl: freezed == friendImageUrl
          ? _value.friendImageUrl
          : friendImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataEntityImpl implements _UserDataEntity {
  _$UserDataEntityImpl(
      {this.friendEmail, this.friendId, this.friendName, this.friendImageUrl});

  factory _$UserDataEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataEntityImplFromJson(json);

  @override
  final String? friendEmail;
  @override
  final String? friendId;
  @override
  final String? friendName;
  @override
  final String? friendImageUrl;

  @override
  String toString() {
    return 'UserDataEntity(friendEmail: $friendEmail, friendId: $friendId, friendName: $friendName, friendImageUrl: $friendImageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataEntityImpl &&
            (identical(other.friendEmail, friendEmail) ||
                other.friendEmail == friendEmail) &&
            (identical(other.friendId, friendId) ||
                other.friendId == friendId) &&
            (identical(other.friendName, friendName) ||
                other.friendName == friendName) &&
            (identical(other.friendImageUrl, friendImageUrl) ||
                other.friendImageUrl == friendImageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, friendEmail, friendId, friendName, friendImageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataEntityImplCopyWith<_$UserDataEntityImpl> get copyWith =>
      __$$UserDataEntityImplCopyWithImpl<_$UserDataEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataEntityImplToJson(
      this,
    );
  }
}

abstract class _UserDataEntity implements UserDataEntity {
  factory _UserDataEntity(
      {final String? friendEmail,
      final String? friendId,
      final String? friendName,
      final String? friendImageUrl}) = _$UserDataEntityImpl;

  factory _UserDataEntity.fromJson(Map<String, dynamic> json) =
      _$UserDataEntityImpl.fromJson;

  @override
  String? get friendEmail;
  @override
  String? get friendId;
  @override
  String? get friendName;
  @override
  String? get friendImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$UserDataEntityImplCopyWith<_$UserDataEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
