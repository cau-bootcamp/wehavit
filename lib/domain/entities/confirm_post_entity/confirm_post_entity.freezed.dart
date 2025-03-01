// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_post_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConfirmPostEntity _$ConfirmPostEntityFromJson(Map<String, dynamic> json) {
  return _ConfirmPostEntity.fromJson(json);
}

/// @nodoc
mixin _$ConfirmPostEntity {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get userImageUrl => throw _privateConstructorUsedError;
  String get resolutionGoalStatement => throw _privateConstructorUsedError;
  String get resolutionId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String> get imageUrlList => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  int get recentStrike => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get hasRested => throw _privateConstructorUsedError;

  /// Serializes this ConfirmPostEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConfirmPostEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfirmPostEntityCopyWith<ConfirmPostEntity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmPostEntityCopyWith<$Res> {
  factory $ConfirmPostEntityCopyWith(ConfirmPostEntity value, $Res Function(ConfirmPostEntity) then) =
      _$ConfirmPostEntityCopyWithImpl<$Res, ConfirmPostEntity>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String id,
      @JsonKey(includeFromJson: false, includeToJson: false) String userName,
      @JsonKey(includeFromJson: false, includeToJson: false) String userImageUrl,
      String resolutionGoalStatement,
      String resolutionId,
      String content,
      List<String> imageUrlList,
      String owner,
      int recentStrike,
      DateTime createdAt,
      DateTime updatedAt,
      bool hasRested});
}

/// @nodoc
class _$ConfirmPostEntityCopyWithImpl<$Res, $Val extends ConfirmPostEntity>
    implements $ConfirmPostEntityCopyWith<$Res> {
  _$ConfirmPostEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfirmPostEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? userImageUrl = null,
    Object? resolutionGoalStatement = null,
    Object? resolutionId = null,
    Object? content = null,
    Object? imageUrlList = null,
    Object? owner = null,
    Object? recentStrike = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasRested = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: null == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      resolutionGoalStatement: null == resolutionGoalStatement
          ? _value.resolutionGoalStatement
          : resolutionGoalStatement // ignore: cast_nullable_to_non_nullable
              as String,
      resolutionId: null == resolutionId
          ? _value.resolutionId
          : resolutionId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrlList: null == imageUrlList
          ? _value.imageUrlList
          : imageUrlList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      recentStrike: null == recentStrike
          ? _value.recentStrike
          : recentStrike // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasRested: null == hasRested
          ? _value.hasRested
          : hasRested // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfirmPostEntityImplCopyWith<$Res> implements $ConfirmPostEntityCopyWith<$Res> {
  factory _$$ConfirmPostEntityImplCopyWith(_$ConfirmPostEntityImpl value, $Res Function(_$ConfirmPostEntityImpl) then) =
      __$$ConfirmPostEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String id,
      @JsonKey(includeFromJson: false, includeToJson: false) String userName,
      @JsonKey(includeFromJson: false, includeToJson: false) String userImageUrl,
      String resolutionGoalStatement,
      String resolutionId,
      String content,
      List<String> imageUrlList,
      String owner,
      int recentStrike,
      DateTime createdAt,
      DateTime updatedAt,
      bool hasRested});
}

/// @nodoc
class __$$ConfirmPostEntityImplCopyWithImpl<$Res> extends _$ConfirmPostEntityCopyWithImpl<$Res, _$ConfirmPostEntityImpl>
    implements _$$ConfirmPostEntityImplCopyWith<$Res> {
  __$$ConfirmPostEntityImplCopyWithImpl(_$ConfirmPostEntityImpl _value, $Res Function(_$ConfirmPostEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConfirmPostEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? userImageUrl = null,
    Object? resolutionGoalStatement = null,
    Object? resolutionId = null,
    Object? content = null,
    Object? imageUrlList = null,
    Object? owner = null,
    Object? recentStrike = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasRested = null,
  }) {
    return _then(_$ConfirmPostEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: null == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      resolutionGoalStatement: null == resolutionGoalStatement
          ? _value.resolutionGoalStatement
          : resolutionGoalStatement // ignore: cast_nullable_to_non_nullable
              as String,
      resolutionId: null == resolutionId
          ? _value.resolutionId
          : resolutionId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrlList: null == imageUrlList
          ? _value._imageUrlList
          : imageUrlList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      recentStrike: null == recentStrike
          ? _value.recentStrike
          : recentStrike // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasRested: null == hasRested
          ? _value.hasRested
          : hasRested // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TimestampConverter()
@DocumentReferenceJsonConverter()
class _$ConfirmPostEntityImpl implements _ConfirmPostEntity {
  _$ConfirmPostEntityImpl(
      {@JsonKey(includeFromJson: false, includeToJson: false) this.id = '',
      @JsonKey(includeFromJson: false, includeToJson: false) this.userName = '',
      @JsonKey(includeFromJson: false, includeToJson: false) this.userImageUrl = '',
      this.resolutionGoalStatement = '',
      this.resolutionId = '',
      this.content = '',
      final List<String> imageUrlList = const [],
      this.owner = '',
      this.recentStrike = 0,
      required this.createdAt,
      required this.updatedAt,
      this.hasRested = false})
      : assert(resolutionGoalStatement != null, 'resolutionGoalStatement must not be null'),
        assert(resolutionGoalStatement!.isNotEmpty, 'resolutionGoalStatement must not be empty'),
        assert(recentStrike != null, 'recentStrike must not be null'),
        assert(recentStrike! >= 0 && recentStrike! <= 170, 'recentStrike must be between b0000000 and b1111111'),
        assert(createdAt != null, 'createdAt must not be null'),
        assert(updatedAt != null, 'createdAt must not be null'),
        assert(owner != null, 'roles(owner) must not be null'),
        _imageUrlList = imageUrlList;

  factory _$ConfirmPostEntityImpl.fromJson(Map<String, dynamic> json) => _$$ConfirmPostEntityImplFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String userName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String userImageUrl;
  @override
  @JsonKey()
  final String resolutionGoalStatement;
  @override
  @JsonKey()
  final String resolutionId;
  @override
  @JsonKey()
  final String content;
  final List<String> _imageUrlList;
  @override
  @JsonKey()
  List<String> get imageUrlList {
    if (_imageUrlList is EqualUnmodifiableListView) return _imageUrlList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrlList);
  }

  @override
  @JsonKey()
  final String owner;
  @override
  @JsonKey()
  final int recentStrike;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool hasRested;

  @override
  String toString() {
    return 'ConfirmPostEntity(id: $id, userName: $userName, userImageUrl: $userImageUrl, resolutionGoalStatement: $resolutionGoalStatement, resolutionId: $resolutionId, content: $content, imageUrlList: $imageUrlList, owner: $owner, recentStrike: $recentStrike, createdAt: $createdAt, updatedAt: $updatedAt, hasRested: $hasRested)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmPostEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) || other.userName == userName) &&
            (identical(other.userImageUrl, userImageUrl) || other.userImageUrl == userImageUrl) &&
            (identical(other.resolutionGoalStatement, resolutionGoalStatement) ||
                other.resolutionGoalStatement == resolutionGoalStatement) &&
            (identical(other.resolutionId, resolutionId) || other.resolutionId == resolutionId) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._imageUrlList, _imageUrlList) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.recentStrike, recentStrike) || other.recentStrike == recentStrike) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt) &&
            (identical(other.hasRested, hasRested) || other.hasRested == hasRested));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userName,
      userImageUrl,
      resolutionGoalStatement,
      resolutionId,
      content,
      const DeepCollectionEquality().hash(_imageUrlList),
      owner,
      recentStrike,
      createdAt,
      updatedAt,
      hasRested);

  /// Create a copy of ConfirmPostEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmPostEntityImplCopyWith<_$ConfirmPostEntityImpl> get copyWith =>
      __$$ConfirmPostEntityImplCopyWithImpl<_$ConfirmPostEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfirmPostEntityImplToJson(
      this,
    );
  }
}

abstract class _ConfirmPostEntity implements ConfirmPostEntity {
  factory _ConfirmPostEntity(
      {@JsonKey(includeFromJson: false, includeToJson: false) final String id,
      @JsonKey(includeFromJson: false, includeToJson: false) final String userName,
      @JsonKey(includeFromJson: false, includeToJson: false) final String userImageUrl,
      final String resolutionGoalStatement,
      final String resolutionId,
      final String content,
      final List<String> imageUrlList,
      final String owner,
      final int recentStrike,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final bool hasRested}) = _$ConfirmPostEntityImpl;

  factory _ConfirmPostEntity.fromJson(Map<String, dynamic> json) = _$ConfirmPostEntityImpl.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get id;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get userName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get userImageUrl;
  @override
  String get resolutionGoalStatement;
  @override
  String get resolutionId;
  @override
  String get content;
  @override
  List<String> get imageUrlList;
  @override
  String get owner;
  @override
  int get recentStrike;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get hasRested;

  /// Create a copy of ConfirmPostEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmPostEntityImplCopyWith<_$ConfirmPostEntityImpl> get copyWith => throw _privateConstructorUsedError;
}
