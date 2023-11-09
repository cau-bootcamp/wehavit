// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReactionModel _$ReactionModelFromJson(Map<String, dynamic> json) {
  return _ReactionModel.fromJson(json);
}

/// @nodoc
mixin _$ReactionModel {
  String get complementerUid => throw _privateConstructorUsedError;
  int get reactionType => throw _privateConstructorUsedError;
  bool get hasRead => throw _privateConstructorUsedError;
  String get instantPhotoUrl => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  Map<String, int> get emoji => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReactionModelCopyWith<ReactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReactionModelCopyWith<$Res> {
  factory $ReactionModelCopyWith(
          ReactionModel value, $Res Function(ReactionModel) then) =
      _$ReactionModelCopyWithImpl<$Res, ReactionModel>;
  @useResult
  $Res call(
      {String complementerUid,
      int reactionType,
      bool hasRead,
      String instantPhotoUrl,
      String comment,
      Map<String, int> emoji});
}

/// @nodoc
class _$ReactionModelCopyWithImpl<$Res, $Val extends ReactionModel>
    implements $ReactionModelCopyWith<$Res> {
  _$ReactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complementerUid = null,
    Object? reactionType = null,
    Object? hasRead = null,
    Object? instantPhotoUrl = null,
    Object? comment = null,
    Object? emoji = null,
  }) {
    return _then(_value.copyWith(
      complementerUid: null == complementerUid
          ? _value.complementerUid
          : complementerUid // ignore: cast_nullable_to_non_nullable
              as String,
      reactionType: null == reactionType
          ? _value.reactionType
          : reactionType // ignore: cast_nullable_to_non_nullable
              as int,
      hasRead: null == hasRead
          ? _value.hasRead
          : hasRead // ignore: cast_nullable_to_non_nullable
              as bool,
      instantPhotoUrl: null == instantPhotoUrl
          ? _value.instantPhotoUrl
          : instantPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReactionModelImplCopyWith<$Res>
    implements $ReactionModelCopyWith<$Res> {
  factory _$$ReactionModelImplCopyWith(
          _$ReactionModelImpl value, $Res Function(_$ReactionModelImpl) then) =
      __$$ReactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String complementerUid,
      int reactionType,
      bool hasRead,
      String instantPhotoUrl,
      String comment,
      Map<String, int> emoji});
}

/// @nodoc
class __$$ReactionModelImplCopyWithImpl<$Res>
    extends _$ReactionModelCopyWithImpl<$Res, _$ReactionModelImpl>
    implements _$$ReactionModelImplCopyWith<$Res> {
  __$$ReactionModelImplCopyWithImpl(
      _$ReactionModelImpl _value, $Res Function(_$ReactionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complementerUid = null,
    Object? reactionType = null,
    Object? hasRead = null,
    Object? instantPhotoUrl = null,
    Object? comment = null,
    Object? emoji = null,
  }) {
    return _then(_$ReactionModelImpl(
      complementerUid: null == complementerUid
          ? _value.complementerUid
          : complementerUid // ignore: cast_nullable_to_non_nullable
              as String,
      reactionType: null == reactionType
          ? _value.reactionType
          : reactionType // ignore: cast_nullable_to_non_nullable
              as int,
      hasRead: null == hasRead
          ? _value.hasRead
          : hasRead // ignore: cast_nullable_to_non_nullable
              as bool,
      instantPhotoUrl: null == instantPhotoUrl
          ? _value.instantPhotoUrl
          : instantPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value._emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReactionModelImpl implements _ReactionModel {
  _$ReactionModelImpl(
      {required this.complementerUid,
      required this.reactionType,
      this.hasRead = false,
      this.instantPhotoUrl = '',
      this.comment = '',
      final Map<String, int> emoji = const {}})
      : _emoji = emoji;

  factory _$ReactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReactionModelImplFromJson(json);

  @override
  final String complementerUid;
  @override
  final int reactionType;
  @override
  @JsonKey()
  final bool hasRead;
  @override
  @JsonKey()
  final String instantPhotoUrl;
  @override
  @JsonKey()
  final String comment;
  final Map<String, int> _emoji;
  @override
  @JsonKey()
  Map<String, int> get emoji {
    if (_emoji is EqualUnmodifiableMapView) return _emoji;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_emoji);
  }

  @override
  String toString() {
    return 'ReactionModel(complementerUid: $complementerUid, reactionType: $reactionType, hasRead: $hasRead, instantPhotoUrl: $instantPhotoUrl, comment: $comment, emoji: $emoji)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionModelImpl &&
            (identical(other.complementerUid, complementerUid) ||
                other.complementerUid == complementerUid) &&
            (identical(other.reactionType, reactionType) ||
                other.reactionType == reactionType) &&
            (identical(other.hasRead, hasRead) || other.hasRead == hasRead) &&
            (identical(other.instantPhotoUrl, instantPhotoUrl) ||
                other.instantPhotoUrl == instantPhotoUrl) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            const DeepCollectionEquality().equals(other._emoji, _emoji));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      complementerUid,
      reactionType,
      hasRead,
      instantPhotoUrl,
      comment,
      const DeepCollectionEquality().hash(_emoji));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactionModelImplCopyWith<_$ReactionModelImpl> get copyWith =>
      __$$ReactionModelImplCopyWithImpl<_$ReactionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReactionModelImplToJson(
      this,
    );
  }
}

abstract class _ReactionModel implements ReactionModel {
  factory _ReactionModel(
      {required final String complementerUid,
      required final int reactionType,
      final bool hasRead,
      final String instantPhotoUrl,
      final String comment,
      final Map<String, int> emoji}) = _$ReactionModelImpl;

  factory _ReactionModel.fromJson(Map<String, dynamic> json) =
      _$ReactionModelImpl.fromJson;

  @override
  String get complementerUid;
  @override
  int get reactionType;
  @override
  bool get hasRead;
  @override
  String get instantPhotoUrl;
  @override
  String get comment;
  @override
  Map<String, int> get emoji;
  @override
  @JsonKey(ignore: true)
  _$$ReactionModelImplCopyWith<_$ReactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
