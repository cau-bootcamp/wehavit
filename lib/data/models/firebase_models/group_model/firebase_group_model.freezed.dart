// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirebaseGroupModel _$FirebaseGroupModelFromJson(Map<String, dynamic> json) {
  return _FirebaseGroupModel.fromJson(json);
}

/// @nodoc
mixin _$FirebaseGroupModel {
  String get groupName => throw _privateConstructorUsedError;
  String get groupDescription => throw _privateConstructorUsedError;
  String get groupRule => throw _privateConstructorUsedError;
  String get groupManagerUid => throw _privateConstructorUsedError;
  int get groupColor => throw _privateConstructorUsedError;
  List<String> get groupMemberUidList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebaseGroupModelCopyWith<FirebaseGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseGroupModelCopyWith<$Res> {
  factory $FirebaseGroupModelCopyWith(
          FirebaseGroupModel value, $Res Function(FirebaseGroupModel) then) =
      _$FirebaseGroupModelCopyWithImpl<$Res, FirebaseGroupModel>;
  @useResult
  $Res call(
      {String groupName,
      String groupDescription,
      String groupRule,
      String groupManagerUid,
      int groupColor,
      List<String> groupMemberUidList});
}

/// @nodoc
class _$FirebaseGroupModelCopyWithImpl<$Res, $Val extends FirebaseGroupModel>
    implements $FirebaseGroupModelCopyWith<$Res> {
  _$FirebaseGroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupName = null,
    Object? groupDescription = null,
    Object? groupRule = null,
    Object? groupManagerUid = null,
    Object? groupColor = null,
    Object? groupMemberUidList = null,
  }) {
    return _then(_value.copyWith(
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      groupDescription: null == groupDescription
          ? _value.groupDescription
          : groupDescription // ignore: cast_nullable_to_non_nullable
              as String,
      groupRule: null == groupRule
          ? _value.groupRule
          : groupRule // ignore: cast_nullable_to_non_nullable
              as String,
      groupManagerUid: null == groupManagerUid
          ? _value.groupManagerUid
          : groupManagerUid // ignore: cast_nullable_to_non_nullable
              as String,
      groupColor: null == groupColor
          ? _value.groupColor
          : groupColor // ignore: cast_nullable_to_non_nullable
              as int,
      groupMemberUidList: null == groupMemberUidList
          ? _value.groupMemberUidList
          : groupMemberUidList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirebaseGroupModelImplCopyWith<$Res>
    implements $FirebaseGroupModelCopyWith<$Res> {
  factory _$$FirebaseGroupModelImplCopyWith(_$FirebaseGroupModelImpl value,
          $Res Function(_$FirebaseGroupModelImpl) then) =
      __$$FirebaseGroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String groupName,
      String groupDescription,
      String groupRule,
      String groupManagerUid,
      int groupColor,
      List<String> groupMemberUidList});
}

/// @nodoc
class __$$FirebaseGroupModelImplCopyWithImpl<$Res>
    extends _$FirebaseGroupModelCopyWithImpl<$Res, _$FirebaseGroupModelImpl>
    implements _$$FirebaseGroupModelImplCopyWith<$Res> {
  __$$FirebaseGroupModelImplCopyWithImpl(_$FirebaseGroupModelImpl _value,
      $Res Function(_$FirebaseGroupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupName = null,
    Object? groupDescription = null,
    Object? groupRule = null,
    Object? groupManagerUid = null,
    Object? groupColor = null,
    Object? groupMemberUidList = null,
  }) {
    return _then(_$FirebaseGroupModelImpl(
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      groupDescription: null == groupDescription
          ? _value.groupDescription
          : groupDescription // ignore: cast_nullable_to_non_nullable
              as String,
      groupRule: null == groupRule
          ? _value.groupRule
          : groupRule // ignore: cast_nullable_to_non_nullable
              as String,
      groupManagerUid: null == groupManagerUid
          ? _value.groupManagerUid
          : groupManagerUid // ignore: cast_nullable_to_non_nullable
              as String,
      groupColor: null == groupColor
          ? _value.groupColor
          : groupColor // ignore: cast_nullable_to_non_nullable
              as int,
      groupMemberUidList: null == groupMemberUidList
          ? _value._groupMemberUidList
          : groupMemberUidList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$FirebaseGroupModelImpl implements _FirebaseGroupModel {
  _$FirebaseGroupModelImpl(
      {required this.groupName,
      required this.groupDescription,
      required this.groupRule,
      required this.groupManagerUid,
      required this.groupColor,
      required final List<String> groupMemberUidList})
      : _groupMemberUidList = groupMemberUidList;

  factory _$FirebaseGroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirebaseGroupModelImplFromJson(json);

  @override
  final String groupName;
  @override
  final String groupDescription;
  @override
  final String groupRule;
  @override
  final String groupManagerUid;
  @override
  final int groupColor;
  final List<String> _groupMemberUidList;
  @override
  List<String> get groupMemberUidList {
    if (_groupMemberUidList is EqualUnmodifiableListView)
      return _groupMemberUidList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupMemberUidList);
  }

  @override
  String toString() {
    return 'FirebaseGroupModel(groupName: $groupName, groupDescription: $groupDescription, groupRule: $groupRule, groupManagerUid: $groupManagerUid, groupColor: $groupColor, groupMemberUidList: $groupMemberUidList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirebaseGroupModelImpl &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.groupDescription, groupDescription) ||
                other.groupDescription == groupDescription) &&
            (identical(other.groupRule, groupRule) ||
                other.groupRule == groupRule) &&
            (identical(other.groupManagerUid, groupManagerUid) ||
                other.groupManagerUid == groupManagerUid) &&
            (identical(other.groupColor, groupColor) ||
                other.groupColor == groupColor) &&
            const DeepCollectionEquality()
                .equals(other._groupMemberUidList, _groupMemberUidList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      groupName,
      groupDescription,
      groupRule,
      groupManagerUid,
      groupColor,
      const DeepCollectionEquality().hash(_groupMemberUidList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirebaseGroupModelImplCopyWith<_$FirebaseGroupModelImpl> get copyWith =>
      __$$FirebaseGroupModelImplCopyWithImpl<_$FirebaseGroupModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirebaseGroupModelImplToJson(
      this,
    );
  }
}

abstract class _FirebaseGroupModel implements FirebaseGroupModel {
  factory _FirebaseGroupModel(
          {required final String groupName,
          required final String groupDescription,
          required final String groupRule,
          required final String groupManagerUid,
          required final int groupColor,
          required final List<String> groupMemberUidList}) =
      _$FirebaseGroupModelImpl;

  factory _FirebaseGroupModel.fromJson(Map<String, dynamic> json) =
      _$FirebaseGroupModelImpl.fromJson;

  @override
  String get groupName;
  @override
  String get groupDescription;
  @override
  String get groupRule;
  @override
  String get groupManagerUid;
  @override
  int get groupColor;
  @override
  List<String> get groupMemberUidList;
  @override
  @JsonKey(ignore: true)
  _$$FirebaseGroupModelImplCopyWith<_$FirebaseGroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
