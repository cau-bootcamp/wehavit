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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FirebaseUserModel _$FirebaseUserModelFromJson(Map<String, dynamic> json) {
  return _FirebaseUserModel.fromJson(json);
}

/// @nodoc
mixin _$FirebaseUserModel {
  String? get handle => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get aboutMe => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  int? get cumulativeGoals => throw _privateConstructorUsedError;
  int? get cumulativePosts => throw _privateConstructorUsedError;
  int? get cumulativeReactions => throw _privateConstructorUsedError;

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
  $Res call(
      {String? handle,
      String? displayName,
      String? imageUrl,
      String? aboutMe,
      @TimestampConverter() DateTime? createdAt,
      int? cumulativeGoals,
      int? cumulativePosts,
      int? cumulativeReactions});
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
    Object? handle = freezed,
    Object? displayName = freezed,
    Object? imageUrl = freezed,
    Object? aboutMe = freezed,
    Object? createdAt = freezed,
    Object? cumulativeGoals = freezed,
    Object? cumulativePosts = freezed,
    Object? cumulativeReactions = freezed,
  }) {
    return _then(_value.copyWith(
      handle: freezed == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      aboutMe: freezed == aboutMe
          ? _value.aboutMe
          : aboutMe // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cumulativeGoals: freezed == cumulativeGoals
          ? _value.cumulativeGoals
          : cumulativeGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      cumulativePosts: freezed == cumulativePosts
          ? _value.cumulativePosts
          : cumulativePosts // ignore: cast_nullable_to_non_nullable
              as int?,
      cumulativeReactions: freezed == cumulativeReactions
          ? _value.cumulativeReactions
          : cumulativeReactions // ignore: cast_nullable_to_non_nullable
              as int?,
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
  $Res call(
      {String? handle,
      String? displayName,
      String? imageUrl,
      String? aboutMe,
      @TimestampConverter() DateTime? createdAt,
      int? cumulativeGoals,
      int? cumulativePosts,
      int? cumulativeReactions});
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
    Object? handle = freezed,
    Object? displayName = freezed,
    Object? imageUrl = freezed,
    Object? aboutMe = freezed,
    Object? createdAt = freezed,
    Object? cumulativeGoals = freezed,
    Object? cumulativePosts = freezed,
    Object? cumulativeReactions = freezed,
  }) {
    return _then(_$FirebaseUserModelImpl(
      handle: freezed == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      aboutMe: freezed == aboutMe
          ? _value.aboutMe
          : aboutMe // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cumulativeGoals: freezed == cumulativeGoals
          ? _value.cumulativeGoals
          : cumulativeGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      cumulativePosts: freezed == cumulativePosts
          ? _value.cumulativePosts
          : cumulativePosts // ignore: cast_nullable_to_non_nullable
              as int?,
      cumulativeReactions: freezed == cumulativeReactions
          ? _value.cumulativeReactions
          : cumulativeReactions // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$FirebaseUserModelImpl implements _FirebaseUserModel {
  const _$FirebaseUserModelImpl(
      {this.handle,
      this.displayName,
      this.imageUrl,
      this.aboutMe,
      @TimestampConverter() this.createdAt,
      this.cumulativeGoals,
      this.cumulativePosts,
      this.cumulativeReactions});

  factory _$FirebaseUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirebaseUserModelImplFromJson(json);

  @override
  final String? handle;
  @override
  final String? displayName;
  @override
  final String? imageUrl;
  @override
  final String? aboutMe;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  final int? cumulativeGoals;
  @override
  final int? cumulativePosts;
  @override
  final int? cumulativeReactions;

  @override
  String toString() {
    return 'FirebaseUserModel(handle: $handle, displayName: $displayName, imageUrl: $imageUrl, aboutMe: $aboutMe, createdAt: $createdAt, cumulativeGoals: $cumulativeGoals, cumulativePosts: $cumulativePosts, cumulativeReactions: $cumulativeReactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirebaseUserModelImpl &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.cumulativeGoals, cumulativeGoals) ||
                other.cumulativeGoals == cumulativeGoals) &&
            (identical(other.cumulativePosts, cumulativePosts) ||
                other.cumulativePosts == cumulativePosts) &&
            (identical(other.cumulativeReactions, cumulativeReactions) ||
                other.cumulativeReactions == cumulativeReactions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      handle,
      displayName,
      imageUrl,
      aboutMe,
      createdAt,
      cumulativeGoals,
      cumulativePosts,
      cumulativeReactions);

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
      {final String? handle,
      final String? displayName,
      final String? imageUrl,
      final String? aboutMe,
      @TimestampConverter() final DateTime? createdAt,
      final int? cumulativeGoals,
      final int? cumulativePosts,
      final int? cumulativeReactions}) = _$FirebaseUserModelImpl;

  factory _FirebaseUserModel.fromJson(Map<String, dynamic> json) =
      _$FirebaseUserModelImpl.fromJson;

  @override
  String? get handle;
  @override
  String? get displayName;
  @override
  String? get imageUrl;
  @override
  String? get aboutMe;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  int? get cumulativeGoals;
  @override
  int? get cumulativePosts;
  @override
  int? get cumulativeReactions;
  @override
  @JsonKey(ignore: true)
  _$$FirebaseUserModelImplCopyWith<_$FirebaseUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
