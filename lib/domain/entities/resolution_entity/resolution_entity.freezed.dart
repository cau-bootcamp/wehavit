// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resolution_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResolutionEntity _$ResolutionEntityFromJson(Map<String, dynamic> json) {
  return _ResolutionEntity.fromJson(json);
}

/// @nodoc
mixin _$ResolutionEntity {
  String? get resolutionId => throw _privateConstructorUsedError;
  String? get resolutionName => throw _privateConstructorUsedError;
  String? get goalStatement => throw _privateConstructorUsedError;
  String? get actionStatement => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  int? get actionPerWeek => throw _privateConstructorUsedError;
  int? get colorIndex => throw _privateConstructorUsedError;
  int? get iconIndex => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  List<UserDataEntity>? get shareFriendEntityList =>
      throw _privateConstructorUsedError;
  List<GroupEntity>? get shareGroupEntityList =>
      throw _privateConstructorUsedError;
  int? get writtenPostCount => throw _privateConstructorUsedError;
  int? get receivedReactionCount => throw _privateConstructorUsedError;
  List<DateTime>? get successWeekMondayList =>
      throw _privateConstructorUsedError;
  List<int>? get weeklyPostCountList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResolutionEntityCopyWith<ResolutionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResolutionEntityCopyWith<$Res> {
  factory $ResolutionEntityCopyWith(
          ResolutionEntity value, $Res Function(ResolutionEntity) then) =
      _$ResolutionEntityCopyWithImpl<$Res, ResolutionEntity>;
  @useResult
  $Res call(
      {String? resolutionId,
      String? resolutionName,
      String? goalStatement,
      String? actionStatement,
      bool? isActive,
      int? actionPerWeek,
      int? colorIndex,
      int? iconIndex,
      DateTime? startDate,
      List<UserDataEntity>? shareFriendEntityList,
      List<GroupEntity>? shareGroupEntityList,
      int? writtenPostCount,
      int? receivedReactionCount,
      List<DateTime>? successWeekMondayList,
      List<int>? weeklyPostCountList});
}

/// @nodoc
class _$ResolutionEntityCopyWithImpl<$Res, $Val extends ResolutionEntity>
    implements $ResolutionEntityCopyWith<$Res> {
  _$ResolutionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolutionId = freezed,
    Object? resolutionName = freezed,
    Object? goalStatement = freezed,
    Object? actionStatement = freezed,
    Object? isActive = freezed,
    Object? actionPerWeek = freezed,
    Object? colorIndex = freezed,
    Object? iconIndex = freezed,
    Object? startDate = freezed,
    Object? shareFriendEntityList = freezed,
    Object? shareGroupEntityList = freezed,
    Object? writtenPostCount = freezed,
    Object? receivedReactionCount = freezed,
    Object? successWeekMondayList = freezed,
    Object? weeklyPostCountList = freezed,
  }) {
    return _then(_value.copyWith(
      resolutionId: freezed == resolutionId
          ? _value.resolutionId
          : resolutionId // ignore: cast_nullable_to_non_nullable
              as String?,
      resolutionName: freezed == resolutionName
          ? _value.resolutionName
          : resolutionName // ignore: cast_nullable_to_non_nullable
              as String?,
      goalStatement: freezed == goalStatement
          ? _value.goalStatement
          : goalStatement // ignore: cast_nullable_to_non_nullable
              as String?,
      actionStatement: freezed == actionStatement
          ? _value.actionStatement
          : actionStatement // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      actionPerWeek: freezed == actionPerWeek
          ? _value.actionPerWeek
          : actionPerWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      colorIndex: freezed == colorIndex
          ? _value.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      iconIndex: freezed == iconIndex
          ? _value.iconIndex
          : iconIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shareFriendEntityList: freezed == shareFriendEntityList
          ? _value.shareFriendEntityList
          : shareFriendEntityList // ignore: cast_nullable_to_non_nullable
              as List<UserDataEntity>?,
      shareGroupEntityList: freezed == shareGroupEntityList
          ? _value.shareGroupEntityList
          : shareGroupEntityList // ignore: cast_nullable_to_non_nullable
              as List<GroupEntity>?,
      writtenPostCount: freezed == writtenPostCount
          ? _value.writtenPostCount
          : writtenPostCount // ignore: cast_nullable_to_non_nullable
              as int?,
      receivedReactionCount: freezed == receivedReactionCount
          ? _value.receivedReactionCount
          : receivedReactionCount // ignore: cast_nullable_to_non_nullable
              as int?,
      successWeekMondayList: freezed == successWeekMondayList
          ? _value.successWeekMondayList
          : successWeekMondayList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      weeklyPostCountList: freezed == weeklyPostCountList
          ? _value.weeklyPostCountList
          : weeklyPostCountList // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResolutionEntityImplCopyWith<$Res>
    implements $ResolutionEntityCopyWith<$Res> {
  factory _$$ResolutionEntityImplCopyWith(_$ResolutionEntityImpl value,
          $Res Function(_$ResolutionEntityImpl) then) =
      __$$ResolutionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? resolutionId,
      String? resolutionName,
      String? goalStatement,
      String? actionStatement,
      bool? isActive,
      int? actionPerWeek,
      int? colorIndex,
      int? iconIndex,
      DateTime? startDate,
      List<UserDataEntity>? shareFriendEntityList,
      List<GroupEntity>? shareGroupEntityList,
      int? writtenPostCount,
      int? receivedReactionCount,
      List<DateTime>? successWeekMondayList,
      List<int>? weeklyPostCountList});
}

/// @nodoc
class __$$ResolutionEntityImplCopyWithImpl<$Res>
    extends _$ResolutionEntityCopyWithImpl<$Res, _$ResolutionEntityImpl>
    implements _$$ResolutionEntityImplCopyWith<$Res> {
  __$$ResolutionEntityImplCopyWithImpl(_$ResolutionEntityImpl _value,
      $Res Function(_$ResolutionEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolutionId = freezed,
    Object? resolutionName = freezed,
    Object? goalStatement = freezed,
    Object? actionStatement = freezed,
    Object? isActive = freezed,
    Object? actionPerWeek = freezed,
    Object? colorIndex = freezed,
    Object? iconIndex = freezed,
    Object? startDate = freezed,
    Object? shareFriendEntityList = freezed,
    Object? shareGroupEntityList = freezed,
    Object? writtenPostCount = freezed,
    Object? receivedReactionCount = freezed,
    Object? successWeekMondayList = freezed,
    Object? weeklyPostCountList = freezed,
  }) {
    return _then(_$ResolutionEntityImpl(
      resolutionId: freezed == resolutionId
          ? _value.resolutionId
          : resolutionId // ignore: cast_nullable_to_non_nullable
              as String?,
      resolutionName: freezed == resolutionName
          ? _value.resolutionName
          : resolutionName // ignore: cast_nullable_to_non_nullable
              as String?,
      goalStatement: freezed == goalStatement
          ? _value.goalStatement
          : goalStatement // ignore: cast_nullable_to_non_nullable
              as String?,
      actionStatement: freezed == actionStatement
          ? _value.actionStatement
          : actionStatement // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      actionPerWeek: freezed == actionPerWeek
          ? _value.actionPerWeek
          : actionPerWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      colorIndex: freezed == colorIndex
          ? _value.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      iconIndex: freezed == iconIndex
          ? _value.iconIndex
          : iconIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shareFriendEntityList: freezed == shareFriendEntityList
          ? _value._shareFriendEntityList
          : shareFriendEntityList // ignore: cast_nullable_to_non_nullable
              as List<UserDataEntity>?,
      shareGroupEntityList: freezed == shareGroupEntityList
          ? _value._shareGroupEntityList
          : shareGroupEntityList // ignore: cast_nullable_to_non_nullable
              as List<GroupEntity>?,
      writtenPostCount: freezed == writtenPostCount
          ? _value.writtenPostCount
          : writtenPostCount // ignore: cast_nullable_to_non_nullable
              as int?,
      receivedReactionCount: freezed == receivedReactionCount
          ? _value.receivedReactionCount
          : receivedReactionCount // ignore: cast_nullable_to_non_nullable
              as int?,
      successWeekMondayList: freezed == successWeekMondayList
          ? _value._successWeekMondayList
          : successWeekMondayList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      weeklyPostCountList: freezed == weeklyPostCountList
          ? _value._weeklyPostCountList
          : weeklyPostCountList // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TimestampConverter()
@DocumentReferenceJsonConverter()
class _$ResolutionEntityImpl implements _ResolutionEntity {
  const _$ResolutionEntityImpl(
      {this.resolutionId,
      this.resolutionName,
      this.goalStatement,
      this.actionStatement,
      this.isActive,
      this.actionPerWeek,
      this.colorIndex,
      this.iconIndex,
      this.startDate,
      final List<UserDataEntity>? shareFriendEntityList,
      final List<GroupEntity>? shareGroupEntityList,
      this.writtenPostCount,
      this.receivedReactionCount,
      final List<DateTime>? successWeekMondayList,
      final List<int>? weeklyPostCountList})
      : _shareFriendEntityList = shareFriendEntityList,
        _shareGroupEntityList = shareGroupEntityList,
        _successWeekMondayList = successWeekMondayList,
        _weeklyPostCountList = weeklyPostCountList;

  factory _$ResolutionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResolutionEntityImplFromJson(json);

  @override
  final String? resolutionId;
  @override
  final String? resolutionName;
  @override
  final String? goalStatement;
  @override
  final String? actionStatement;
  @override
  final bool? isActive;
  @override
  final int? actionPerWeek;
  @override
  final int? colorIndex;
  @override
  final int? iconIndex;
  @override
  final DateTime? startDate;
  final List<UserDataEntity>? _shareFriendEntityList;
  @override
  List<UserDataEntity>? get shareFriendEntityList {
    final value = _shareFriendEntityList;
    if (value == null) return null;
    if (_shareFriendEntityList is EqualUnmodifiableListView)
      return _shareFriendEntityList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<GroupEntity>? _shareGroupEntityList;
  @override
  List<GroupEntity>? get shareGroupEntityList {
    final value = _shareGroupEntityList;
    if (value == null) return null;
    if (_shareGroupEntityList is EqualUnmodifiableListView)
      return _shareGroupEntityList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? writtenPostCount;
  @override
  final int? receivedReactionCount;
  final List<DateTime>? _successWeekMondayList;
  @override
  List<DateTime>? get successWeekMondayList {
    final value = _successWeekMondayList;
    if (value == null) return null;
    if (_successWeekMondayList is EqualUnmodifiableListView)
      return _successWeekMondayList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _weeklyPostCountList;
  @override
  List<int>? get weeklyPostCountList {
    final value = _weeklyPostCountList;
    if (value == null) return null;
    if (_weeklyPostCountList is EqualUnmodifiableListView)
      return _weeklyPostCountList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ResolutionEntity(resolutionId: $resolutionId, resolutionName: $resolutionName, goalStatement: $goalStatement, actionStatement: $actionStatement, isActive: $isActive, actionPerWeek: $actionPerWeek, colorIndex: $colorIndex, iconIndex: $iconIndex, startDate: $startDate, shareFriendEntityList: $shareFriendEntityList, shareGroupEntityList: $shareGroupEntityList, writtenPostCount: $writtenPostCount, receivedReactionCount: $receivedReactionCount, successWeekMondayList: $successWeekMondayList, weeklyPostCountList: $weeklyPostCountList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResolutionEntityImpl &&
            (identical(other.resolutionId, resolutionId) ||
                other.resolutionId == resolutionId) &&
            (identical(other.resolutionName, resolutionName) ||
                other.resolutionName == resolutionName) &&
            (identical(other.goalStatement, goalStatement) ||
                other.goalStatement == goalStatement) &&
            (identical(other.actionStatement, actionStatement) ||
                other.actionStatement == actionStatement) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.actionPerWeek, actionPerWeek) ||
                other.actionPerWeek == actionPerWeek) &&
            (identical(other.colorIndex, colorIndex) ||
                other.colorIndex == colorIndex) &&
            (identical(other.iconIndex, iconIndex) ||
                other.iconIndex == iconIndex) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            const DeepCollectionEquality()
                .equals(other._shareFriendEntityList, _shareFriendEntityList) &&
            const DeepCollectionEquality()
                .equals(other._shareGroupEntityList, _shareGroupEntityList) &&
            (identical(other.writtenPostCount, writtenPostCount) ||
                other.writtenPostCount == writtenPostCount) &&
            (identical(other.receivedReactionCount, receivedReactionCount) ||
                other.receivedReactionCount == receivedReactionCount) &&
            const DeepCollectionEquality()
                .equals(other._successWeekMondayList, _successWeekMondayList) &&
            const DeepCollectionEquality()
                .equals(other._weeklyPostCountList, _weeklyPostCountList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      resolutionId,
      resolutionName,
      goalStatement,
      actionStatement,
      isActive,
      actionPerWeek,
      colorIndex,
      iconIndex,
      startDate,
      const DeepCollectionEquality().hash(_shareFriendEntityList),
      const DeepCollectionEquality().hash(_shareGroupEntityList),
      writtenPostCount,
      receivedReactionCount,
      const DeepCollectionEquality().hash(_successWeekMondayList),
      const DeepCollectionEquality().hash(_weeklyPostCountList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResolutionEntityImplCopyWith<_$ResolutionEntityImpl> get copyWith =>
      __$$ResolutionEntityImplCopyWithImpl<_$ResolutionEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResolutionEntityImplToJson(
      this,
    );
  }
}

abstract class _ResolutionEntity implements ResolutionEntity {
  const factory _ResolutionEntity(
      {final String? resolutionId,
      final String? resolutionName,
      final String? goalStatement,
      final String? actionStatement,
      final bool? isActive,
      final int? actionPerWeek,
      final int? colorIndex,
      final int? iconIndex,
      final DateTime? startDate,
      final List<UserDataEntity>? shareFriendEntityList,
      final List<GroupEntity>? shareGroupEntityList,
      final int? writtenPostCount,
      final int? receivedReactionCount,
      final List<DateTime>? successWeekMondayList,
      final List<int>? weeklyPostCountList}) = _$ResolutionEntityImpl;

  factory _ResolutionEntity.fromJson(Map<String, dynamic> json) =
      _$ResolutionEntityImpl.fromJson;

  @override
  String? get resolutionId;
  @override
  String? get resolutionName;
  @override
  String? get goalStatement;
  @override
  String? get actionStatement;
  @override
  bool? get isActive;
  @override
  int? get actionPerWeek;
  @override
  int? get colorIndex;
  @override
  int? get iconIndex;
  @override
  DateTime? get startDate;
  @override
  List<UserDataEntity>? get shareFriendEntityList;
  @override
  List<GroupEntity>? get shareGroupEntityList;
  @override
  int? get writtenPostCount;
  @override
  int? get receivedReactionCount;
  @override
  List<DateTime>? get successWeekMondayList;
  @override
  List<int>? get weeklyPostCountList;
  @override
  @JsonKey(ignore: true)
  _$$ResolutionEntityImplCopyWith<_$ResolutionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
