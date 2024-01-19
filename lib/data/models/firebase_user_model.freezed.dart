// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirebaseUserModel _$FirebaseUserModelFromJson(Map<String, dynamic> json) {
  return _FirebaseUserModel.fromJson(json);
}

/// @nodoc
mixin _$FirebaseUserModel {
  String? get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebaseUserModelCopyWith<FirebaseUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseUserModelCopyWith<$Res> {
  factory $FirebaseUserModelCopyWith(
          FirebaseUserModel value, $Res Function(FirebaseUserModel) then) =
      _$FirebaseUserModelCopyWithImpl<$Res, FirebaseUserModel>;
  @useResult
  $Res call({String? email, String? displayName, String? imageUrl});
}

/// @nodoc
class _$FirebaseUserModelCopyWithImpl<$Res, $Val extends FirebaseUserModel>
    implements $FirebaseUserModelCopyWith<$Res> {
  _$FirebaseUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? displayName = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirebaseUserModelImplCopyWith<$Res>
    implements $FirebaseUserModelCopyWith<$Res> {
  factory _$$FirebaseUserModelImplCopyWith(_$FirebaseUserModelImpl value,
          $Res Function(_$FirebaseUserModelImpl) then) =
      __$$FirebaseUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? displayName, String? imageUrl});
}

/// @nodoc
class __$$FirebaseUserModelImplCopyWithImpl<$Res>
    extends _$FirebaseUserModelCopyWithImpl<$Res, _$FirebaseUserModelImpl>
    implements _$$FirebaseUserModelImplCopyWith<$Res> {
  __$$FirebaseUserModelImplCopyWithImpl(_$FirebaseUserModelImpl _value,
      $Res Function(_$FirebaseUserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? displayName = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$FirebaseUserModelImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
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
class _$FirebaseUserModelImpl implements _FirebaseUserModel {
  const _$FirebaseUserModelImpl({this.email, this.displayName, this.imageUrl});

  factory _$FirebaseUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirebaseUserModelImplFromJson(json);

  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'FirebaseUserModel(email: $email, displayName: $displayName, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirebaseUserModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, displayName, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirebaseUserModelImplCopyWith<_$FirebaseUserModelImpl> get copyWith =>
      __$$FirebaseUserModelImplCopyWithImpl<_$FirebaseUserModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirebaseUserModelImplToJson(
      this,
    );
  }
}

abstract class _FirebaseUserModel implements FirebaseUserModel {
  const factory _FirebaseUserModel(
      {final String? email,
      final String? displayName,
      final String? imageUrl}) = _$FirebaseUserModelImpl;

  factory _FirebaseUserModel.fromJson(Map<String, dynamic> json) =
      _$FirebaseUserModelImpl.fromJson;

  @override
  String? get email;
  @override
  String? get displayName;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$FirebaseUserModelImplCopyWith<_$FirebaseUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
