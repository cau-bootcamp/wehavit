// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reaction_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReactionEntity _$ReactionEntityFromJson(Map<String, dynamic> json) {
  return _ReactionEntity.fromJson(json);
}

/// @nodoc
mixin _$ReactionEntity {
  String get complimenterUid => throw _privateConstructorUsedError;
  int get reactionType => throw _privateConstructorUsedError;
  String get quickShotUrl => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  Map<String, int> get emoji => throw _privateConstructorUsedError;

  /// Serializes this ReactionEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReactionEntityCopyWith<ReactionEntity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReactionEntityCopyWith<$Res> {
  factory $ReactionEntityCopyWith(ReactionEntity value, $Res Function(ReactionEntity) then) =
      _$ReactionEntityCopyWithImpl<$Res, ReactionEntity>;
  @useResult
  $Res call({String complimenterUid, int reactionType, String quickShotUrl, String comment, Map<String, int> emoji});
}

/// @nodoc
class _$ReactionEntityCopyWithImpl<$Res, $Val extends ReactionEntity> implements $ReactionEntityCopyWith<$Res> {
  _$ReactionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complimenterUid = null,
    Object? reactionType = null,
    Object? quickShotUrl = null,
    Object? comment = null,
    Object? emoji = null,
  }) {
    return _then(_value.copyWith(
      complimenterUid: null == complimenterUid
          ? _value.complimenterUid
          : complimenterUid // ignore: cast_nullable_to_non_nullable
              as String,
      reactionType: null == reactionType
          ? _value.reactionType
          : reactionType // ignore: cast_nullable_to_non_nullable
              as int,
      quickShotUrl: null == quickShotUrl
          ? _value.quickShotUrl
          : quickShotUrl // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ReactionEntityImplCopyWith<$Res> implements $ReactionEntityCopyWith<$Res> {
  factory _$$ReactionEntityImplCopyWith(_$ReactionEntityImpl value, $Res Function(_$ReactionEntityImpl) then) =
      __$$ReactionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String complimenterUid, int reactionType, String quickShotUrl, String comment, Map<String, int> emoji});
}

/// @nodoc
class __$$ReactionEntityImplCopyWithImpl<$Res> extends _$ReactionEntityCopyWithImpl<$Res, _$ReactionEntityImpl>
    implements _$$ReactionEntityImplCopyWith<$Res> {
  __$$ReactionEntityImplCopyWithImpl(_$ReactionEntityImpl _value, $Res Function(_$ReactionEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complimenterUid = null,
    Object? reactionType = null,
    Object? quickShotUrl = null,
    Object? comment = null,
    Object? emoji = null,
  }) {
    return _then(_$ReactionEntityImpl(
      complimenterUid: null == complimenterUid
          ? _value.complimenterUid
          : complimenterUid // ignore: cast_nullable_to_non_nullable
              as String,
      reactionType: null == reactionType
          ? _value.reactionType
          : reactionType // ignore: cast_nullable_to_non_nullable
              as int,
      quickShotUrl: null == quickShotUrl
          ? _value.quickShotUrl
          : quickShotUrl // ignore: cast_nullable_to_non_nullable
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
class _$ReactionEntityImpl implements _ReactionEntity {
  _$ReactionEntityImpl(
      {required this.complimenterUid,
      required this.reactionType,
      this.quickShotUrl = '',
      this.comment = '',
      final Map<String, int> emoji = const {}})
      : _emoji = emoji;

  factory _$ReactionEntityImpl.fromJson(Map<String, dynamic> json) => _$$ReactionEntityImplFromJson(json);

  @override
  final String complimenterUid;
  @override
  final int reactionType;
  @override
  @JsonKey()
  final String quickShotUrl;
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
    return 'ReactionEntity(complimenterUid: $complimenterUid, reactionType: $reactionType, quickShotUrl: $quickShotUrl, comment: $comment, emoji: $emoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionEntityImpl &&
            (identical(other.complimenterUid, complimenterUid) || other.complimenterUid == complimenterUid) &&
            (identical(other.reactionType, reactionType) || other.reactionType == reactionType) &&
            (identical(other.quickShotUrl, quickShotUrl) || other.quickShotUrl == quickShotUrl) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            const DeepCollectionEquality().equals(other._emoji, _emoji));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, complimenterUid, reactionType, quickShotUrl, comment, const DeepCollectionEquality().hash(_emoji));

  /// Create a copy of ReactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactionEntityImplCopyWith<_$ReactionEntityImpl> get copyWith =>
      __$$ReactionEntityImplCopyWithImpl<_$ReactionEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReactionEntityImplToJson(
      this,
    );
  }
}

abstract class _ReactionEntity implements ReactionEntity {
  factory _ReactionEntity(
      {required final String complimenterUid,
      required final int reactionType,
      final String quickShotUrl,
      final String comment,
      final Map<String, int> emoji}) = _$ReactionEntityImpl;

  factory _ReactionEntity.fromJson(Map<String, dynamic> json) = _$ReactionEntityImpl.fromJson;

  @override
  String get complimenterUid;
  @override
  int get reactionType;
  @override
  String get quickShotUrl;
  @override
  String get comment;
  @override
  Map<String, int> get emoji;

  /// Create a copy of ReactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReactionEntityImplCopyWith<_$ReactionEntityImpl> get copyWith => throw _privateConstructorUsedError;
}
