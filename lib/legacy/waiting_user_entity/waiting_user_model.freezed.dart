// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waiting_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WaitingUser _$WaitingUserFromJson(Map<String, dynamic> json) {
  return _WaitingUser.fromJson(json);
}

/// @nodoc
mixin _$WaitingUser {
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaitingUserCopyWith<WaitingUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaitingUserCopyWith<$Res> {
  factory $WaitingUserCopyWith(
          WaitingUser value, $Res Function(WaitingUser) then) =
      _$WaitingUserCopyWithImpl<$Res, WaitingUser>;
  @useResult
  $Res call(
      {DateTime? updatedAt,
      String? userId,
      String? name,
      String? email,
      String? imageUrl});
}

/// @nodoc
class _$WaitingUserCopyWithImpl<$Res, $Val extends WaitingUser>
    implements $WaitingUserCopyWith<$Res> {
  _$WaitingUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = freezed,
    Object? userId = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WaitingUserImplCopyWith<$Res>
    implements $WaitingUserCopyWith<$Res> {
  factory _$$WaitingUserImplCopyWith(
          _$WaitingUserImpl value, $Res Function(_$WaitingUserImpl) then) =
      __$$WaitingUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? updatedAt,
      String? userId,
      String? name,
      String? email,
      String? imageUrl});
}

/// @nodoc
class __$$WaitingUserImplCopyWithImpl<$Res>
    extends _$WaitingUserCopyWithImpl<$Res, _$WaitingUserImpl>
    implements _$$WaitingUserImplCopyWith<$Res> {
  __$$WaitingUserImplCopyWithImpl(
      _$WaitingUserImpl _value, $Res Function(_$WaitingUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = freezed,
    Object? userId = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$WaitingUserImpl(
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TimestampConverter()
class _$WaitingUserImpl implements _WaitingUser {
  const _$WaitingUserImpl(
      {this.updatedAt, this.userId, this.name, this.email, this.imageUrl});

  factory _$WaitingUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaitingUserImplFromJson(json);

  @override
  final DateTime? updatedAt;
  @override
  final String? userId;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'WaitingUser(updatedAt: $updatedAt, userId: $userId, name: $name, email: $email, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaitingUserImpl &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, updatedAt, userId, name, email, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaitingUserImplCopyWith<_$WaitingUserImpl> get copyWith =>
      __$$WaitingUserImplCopyWithImpl<_$WaitingUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaitingUserImplToJson(
      this,
    );
  }
}

abstract class _WaitingUser implements WaitingUser {
  const factory _WaitingUser(
      {final DateTime? updatedAt,
      final String? userId,
      final String? name,
      final String? email,
      final String? imageUrl}) = _$WaitingUserImpl;

  factory _WaitingUser.fromJson(Map<String, dynamic> json) =
      _$WaitingUserImpl.fromJson;

  @override
  DateTime? get updatedAt;
  @override
  String? get userId;
  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$WaitingUserImplCopyWith<_$WaitingUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
