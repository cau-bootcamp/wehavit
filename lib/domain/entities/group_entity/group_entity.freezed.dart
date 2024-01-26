// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupEntity _$GroupEntityFromJson(Map<String, dynamic> json) {
  return _GroupEntity.fromJson(json);
}

/// @nodoc
mixin _$GroupEntity {
  String get groupName => throw _privateConstructorUsedError;
  String? get groupDescription => throw _privateConstructorUsedError;
  String? get groupRule => throw _privateConstructorUsedError;
  String get groupManagerUid => throw _privateConstructorUsedError;
  List<String> get groupMemberUid => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupEntityCopyWith<GroupEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupEntityCopyWith<$Res> {
  factory $GroupEntityCopyWith(
          GroupEntity value, $Res Function(GroupEntity) then) =
      _$GroupEntityCopyWithImpl<$Res, GroupEntity>;
  @useResult
  $Res call(
      {String groupName,
      String? groupDescription,
      String? groupRule,
      String groupManagerUid,
      List<String> groupMemberUid,
      String groupId});
}

/// @nodoc
class _$GroupEntityCopyWithImpl<$Res, $Val extends GroupEntity>
    implements $GroupEntityCopyWith<$Res> {
  _$GroupEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupName = null,
    Object? groupDescription = freezed,
    Object? groupRule = freezed,
    Object? groupManagerUid = null,
    Object? groupMemberUid = null,
    Object? groupId = null,
  }) {
    return _then(_value.copyWith(
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      groupDescription: freezed == groupDescription
          ? _value.groupDescription
          : groupDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      groupRule: freezed == groupRule
          ? _value.groupRule
          : groupRule // ignore: cast_nullable_to_non_nullable
              as String?,
      groupManagerUid: null == groupManagerUid
          ? _value.groupManagerUid
          : groupManagerUid // ignore: cast_nullable_to_non_nullable
              as String,
      groupMemberUid: null == groupMemberUid
          ? _value.groupMemberUid
          : groupMemberUid // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupEntityImplCopyWith<$Res>
    implements $GroupEntityCopyWith<$Res> {
  factory _$$GroupEntityImplCopyWith(
          _$GroupEntityImpl value, $Res Function(_$GroupEntityImpl) then) =
      __$$GroupEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String groupName,
      String? groupDescription,
      String? groupRule,
      String groupManagerUid,
      List<String> groupMemberUid,
      String groupId});
}

/// @nodoc
class __$$GroupEntityImplCopyWithImpl<$Res>
    extends _$GroupEntityCopyWithImpl<$Res, _$GroupEntityImpl>
    implements _$$GroupEntityImplCopyWith<$Res> {
  __$$GroupEntityImplCopyWithImpl(
      _$GroupEntityImpl _value, $Res Function(_$GroupEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupName = null,
    Object? groupDescription = freezed,
    Object? groupRule = freezed,
    Object? groupManagerUid = null,
    Object? groupMemberUid = null,
    Object? groupId = null,
  }) {
    return _then(_$GroupEntityImpl(
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      groupDescription: freezed == groupDescription
          ? _value.groupDescription
          : groupDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      groupRule: freezed == groupRule
          ? _value.groupRule
          : groupRule // ignore: cast_nullable_to_non_nullable
              as String?,
      groupManagerUid: null == groupManagerUid
          ? _value.groupManagerUid
          : groupManagerUid // ignore: cast_nullable_to_non_nullable
              as String,
      groupMemberUid: null == groupMemberUid
          ? _value._groupMemberUid
          : groupMemberUid // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$GroupEntityImpl implements _GroupEntity {
  _$GroupEntityImpl(
      {required this.groupName,
      this.groupDescription = '',
      this.groupRule = '',
      required this.groupManagerUid,
      required final List<String> groupMemberUid,
      required this.groupId})
      : _groupMemberUid = groupMemberUid;

  factory _$GroupEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupEntityImplFromJson(json);

  @override
  final String groupName;
  @override
  @JsonKey()
  final String? groupDescription;
  @override
  @JsonKey()
  final String? groupRule;
  @override
  final String groupManagerUid;
  final List<String> _groupMemberUid;
  @override
  List<String> get groupMemberUid {
    if (_groupMemberUid is EqualUnmodifiableListView) return _groupMemberUid;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupMemberUid);
  }

  @override
  final String groupId;

  @override
  String toString() {
    return 'GroupEntity(groupName: $groupName, groupDescription: $groupDescription, groupRule: $groupRule, groupManagerUid: $groupManagerUid, groupMemberUid: $groupMemberUid, groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupEntityImpl &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.groupDescription, groupDescription) ||
                other.groupDescription == groupDescription) &&
            (identical(other.groupRule, groupRule) ||
                other.groupRule == groupRule) &&
            (identical(other.groupManagerUid, groupManagerUid) ||
                other.groupManagerUid == groupManagerUid) &&
            const DeepCollectionEquality()
                .equals(other._groupMemberUid, _groupMemberUid) &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      groupName,
      groupDescription,
      groupRule,
      groupManagerUid,
      const DeepCollectionEquality().hash(_groupMemberUid),
      groupId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupEntityImplCopyWith<_$GroupEntityImpl> get copyWith =>
      __$$GroupEntityImplCopyWithImpl<_$GroupEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupEntityImplToJson(
      this,
    );
  }
}

abstract class _GroupEntity implements GroupEntity {
  factory _GroupEntity(
      {required final String groupName,
      final String? groupDescription,
      final String? groupRule,
      required final String groupManagerUid,
      required final List<String> groupMemberUid,
      required final String groupId}) = _$GroupEntityImpl;

  factory _GroupEntity.fromJson(Map<String, dynamic> json) =
      _$GroupEntityImpl.fromJson;

  @override
  String get groupName;
  @override
  String? get groupDescription;
  @override
  String? get groupRule;
  @override
  String get groupManagerUid;
  @override
  List<String> get groupMemberUid;
  @override
  String get groupId;
  @override
  @JsonKey(ignore: true)
  _$$GroupEntityImplCopyWith<_$GroupEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
