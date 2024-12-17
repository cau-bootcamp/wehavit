// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_announcement_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupAnnouncementEntity _$GroupAnnouncementEntityFromJson(Map<String, dynamic> json) {
  return _GroupAnnouncementEntity.fromJson(json);
}

/// @nodoc
mixin _$GroupAnnouncementEntity {
  String get groupId => throw _privateConstructorUsedError;
  String get writerUid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get readByUidList => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: true, includeToJson: false)
  String get groupAnnouncementId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupAnnouncementEntityCopyWith<GroupAnnouncementEntity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupAnnouncementEntityCopyWith<$Res> {
  factory $GroupAnnouncementEntityCopyWith(GroupAnnouncementEntity value, $Res Function(GroupAnnouncementEntity) then) =
      _$GroupAnnouncementEntityCopyWithImpl<$Res, GroupAnnouncementEntity>;
  @useResult
  $Res call(
      {String groupId,
      String writerUid,
      String title,
      String content,
      @TimestampConverter() DateTime createdAt,
      List<String> readByUidList,
      @JsonKey(includeFromJson: true, includeToJson: false) String groupAnnouncementId});
}

/// @nodoc
class _$GroupAnnouncementEntityCopyWithImpl<$Res, $Val extends GroupAnnouncementEntity>
    implements $GroupAnnouncementEntityCopyWith<$Res> {
  _$GroupAnnouncementEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? writerUid = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? readByUidList = null,
    Object? groupAnnouncementId = null,
  }) {
    return _then(_value.copyWith(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      writerUid: null == writerUid
          ? _value.writerUid
          : writerUid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readByUidList: null == readByUidList
          ? _value.readByUidList
          : readByUidList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupAnnouncementId: null == groupAnnouncementId
          ? _value.groupAnnouncementId
          : groupAnnouncementId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupAnnouncementEntityImplCopyWith<$Res> implements $GroupAnnouncementEntityCopyWith<$Res> {
  factory _$$GroupAnnouncementEntityImplCopyWith(
          _$GroupAnnouncementEntityImpl value, $Res Function(_$GroupAnnouncementEntityImpl) then) =
      __$$GroupAnnouncementEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String groupId,
      String writerUid,
      String title,
      String content,
      @TimestampConverter() DateTime createdAt,
      List<String> readByUidList,
      @JsonKey(includeFromJson: true, includeToJson: false) String groupAnnouncementId});
}

/// @nodoc
class __$$GroupAnnouncementEntityImplCopyWithImpl<$Res>
    extends _$GroupAnnouncementEntityCopyWithImpl<$Res, _$GroupAnnouncementEntityImpl>
    implements _$$GroupAnnouncementEntityImplCopyWith<$Res> {
  __$$GroupAnnouncementEntityImplCopyWithImpl(
      _$GroupAnnouncementEntityImpl _value, $Res Function(_$GroupAnnouncementEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? writerUid = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? readByUidList = null,
    Object? groupAnnouncementId = null,
  }) {
    return _then(_$GroupAnnouncementEntityImpl(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      writerUid: null == writerUid
          ? _value.writerUid
          : writerUid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readByUidList: null == readByUidList
          ? _value._readByUidList
          : readByUidList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupAnnouncementId: null == groupAnnouncementId
          ? _value.groupAnnouncementId
          : groupAnnouncementId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$GroupAnnouncementEntityImpl implements _GroupAnnouncementEntity {
  _$GroupAnnouncementEntityImpl(
      {required this.groupId,
      required this.writerUid,
      required this.title,
      required this.content,
      @TimestampConverter() required this.createdAt,
      required final List<String> readByUidList,
      @JsonKey(includeFromJson: true, includeToJson: false) required this.groupAnnouncementId})
      : _readByUidList = readByUidList;

  factory _$GroupAnnouncementEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupAnnouncementEntityImplFromJson(json);

  @override
  final String groupId;
  @override
  final String writerUid;
  @override
  final String title;
  @override
  final String content;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  final List<String> _readByUidList;
  @override
  List<String> get readByUidList {
    if (_readByUidList is EqualUnmodifiableListView) return _readByUidList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readByUidList);
  }

  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  final String groupAnnouncementId;

  @override
  String toString() {
    return 'GroupAnnouncementEntity(groupId: $groupId, writerUid: $writerUid, title: $title, content: $content, createdAt: $createdAt, readByUidList: $readByUidList, groupAnnouncementId: $groupAnnouncementId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupAnnouncementEntityImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.writerUid, writerUid) || other.writerUid == writerUid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._readByUidList, _readByUidList) &&
            (identical(other.groupAnnouncementId, groupAnnouncementId) ||
                other.groupAnnouncementId == groupAnnouncementId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, groupId, writerUid, title, content, createdAt,
      const DeepCollectionEquality().hash(_readByUidList), groupAnnouncementId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupAnnouncementEntityImplCopyWith<_$GroupAnnouncementEntityImpl> get copyWith =>
      __$$GroupAnnouncementEntityImplCopyWithImpl<_$GroupAnnouncementEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupAnnouncementEntityImplToJson(
      this,
    );
  }
}

abstract class _GroupAnnouncementEntity implements GroupAnnouncementEntity {
  factory _GroupAnnouncementEntity(
          {required final String groupId,
          required final String writerUid,
          required final String title,
          required final String content,
          @TimestampConverter() required final DateTime createdAt,
          required final List<String> readByUidList,
          @JsonKey(includeFromJson: true, includeToJson: false) required final String groupAnnouncementId}) =
      _$GroupAnnouncementEntityImpl;

  factory _GroupAnnouncementEntity.fromJson(Map<String, dynamic> json) = _$GroupAnnouncementEntityImpl.fromJson;

  @override
  String get groupId;
  @override
  String get writerUid;
  @override
  String get title;
  @override
  String get content;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  List<String> get readByUidList;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  String get groupAnnouncementId;
  @override
  @JsonKey(ignore: true)
  _$$GroupAnnouncementEntityImplCopyWith<_$GroupAnnouncementEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
