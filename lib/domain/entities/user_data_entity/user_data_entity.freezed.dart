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
  String? get userEmail => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get userImageUrl => throw _privateConstructorUsedError;

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
      {String? userEmail,
      String? userId,
      String? userName,
      String? userImageUrl});
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
    Object? userEmail = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userImageUrl: freezed == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
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
      {String? userEmail,
      String? userId,
      String? userName,
      String? userImageUrl});
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
    Object? userEmail = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userImageUrl = freezed,
  }) {
    return _then(_$UserDataEntityImpl(
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userImageUrl: freezed == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$UserDataEntityImpl implements _UserDataEntity {
  _$UserDataEntityImpl(
      {this.userEmail, this.userId, this.userName, this.userImageUrl});

  factory _$UserDataEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataEntityImplFromJson(json);

  @override
  final String? userEmail;
  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final String? userImageUrl;

  @override
  String toString() {
    return 'UserDataEntity(userEmail: $userEmail, userId: $userId, userName: $userName, userImageUrl: $userImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataEntityImpl &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImageUrl, userImageUrl) ||
                other.userImageUrl == userImageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userEmail, userId, userName, userImageUrl);

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
      {final String? userEmail,
      final String? userId,
      final String? userName,
      final String? userImageUrl}) = _$UserDataEntityImpl;

  factory _UserDataEntity.fromJson(Map<String, dynamic> json) =
      _$UserDataEntityImpl.fromJson;

  @override
  String? get userEmail;
  @override
  String? get userId;
  @override
  String? get userName;
  @override
  String? get userImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$UserDataEntityImplCopyWith<_$UserDataEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
