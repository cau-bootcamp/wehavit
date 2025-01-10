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
  String get resolutionId => throw _privateConstructorUsedError;
  String get resolutionName => throw _privateConstructorUsedError;
  String get goalStatement => throw _privateConstructorUsedError;
  String get actionStatement => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get actionPerWeek => throw _privateConstructorUsedError;
  int get colorIndex => throw _privateConstructorUsedError;
  int get iconIndex => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  List<UserDataEntity> get shareFriendEntityList => throw _privateConstructorUsedError;
  List<GroupEntity> get shareGroupEntityList => throw _privateConstructorUsedError;
  int get writtenPostCount => throw _privateConstructorUsedError;
  int get receivedReactionCount => throw _privateConstructorUsedError;
  List<DateTime> get successWeekMondayList => throw _privateConstructorUsedError;
  List<int> get weeklyPostCountList => throw _privateConstructorUsedError;

  /// Serializes this ResolutionEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResolutionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResolutionEntityCopyWith<ResolutionEntity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResolutionEntityCopyWith<$Res> {
  factory $ResolutionEntityCopyWith(ResolutionEntity value, $Res Function(ResolutionEntity) then) =
      _$ResolutionEntityCopyWithImpl<$Res, ResolutionEntity>;
  @useResult
  $Res call(
      {String resolutionId,
      String resolutionName,
      String goalStatement,
      String actionStatement,
      bool isActive,
      int actionPerWeek,
      int colorIndex,
      int iconIndex,
      DateTime startDate,
      List<UserDataEntity> shareFriendEntityList,
      List<GroupEntity> shareGroupEntityList,
      int writtenPostCount,
      int receivedReactionCount,
      List<DateTime> successWeekMondayList,
      List<int> weeklyPostCountList});
}

/// @nodoc
class _$ResolutionEntityCopyWithImpl<$Res, $Val extends ResolutionEntity> implements $ResolutionEntityCopyWith<$Res> {
  _$ResolutionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResolutionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolutionId = null,
    Object? resolutionName = null,
    Object? goalStatement = null,
    Object? actionStatement = null,
    Object? isActive = null,
    Object? actionPerWeek = null,
    Object? colorIndex = null,
    Object? iconIndex = null,
    Object? startDate = null,
    Object? shareFriendEntityList = null,
    Object? shareGroupEntityList = null,
    Object? writtenPostCount = null,
    Object? receivedReactionCount = null,
    Object? successWeekMondayList = null,
    Object? weeklyPostCountList = null,
  }) {
    return _then(_value.copyWith(
      resolutionId: null == resolutionId
          ? _value.resolutionId
          : resolutionId // ignore: cast_nullable_to_non_nullable
              as String,
      resolutionName: null == resolutionName
          ? _value.resolutionName
          : resolutionName // ignore: cast_nullable_to_non_nullable
              as String,
      goalStatement: null == goalStatement
          ? _value.goalStatement
          : goalStatement // ignore: cast_nullable_to_non_nullable
              as String,
      actionStatement: null == actionStatement
          ? _value.actionStatement
          : actionStatement // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      actionPerWeek: null == actionPerWeek
          ? _value.actionPerWeek
          : actionPerWeek // ignore: cast_nullable_to_non_nullable
              as int,
      colorIndex: null == colorIndex
          ? _value.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int,
      iconIndex: null == iconIndex
          ? _value.iconIndex
          : iconIndex // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shareFriendEntityList: null == shareFriendEntityList
          ? _value.shareFriendEntityList
          : shareFriendEntityList // ignore: cast_nullable_to_non_nullable
              as List<UserDataEntity>,
      shareGroupEntityList: null == shareGroupEntityList
          ? _value.shareGroupEntityList
          : shareGroupEntityList // ignore: cast_nullable_to_non_nullable
              as List<GroupEntity>,
      writtenPostCount: null == writtenPostCount
          ? _value.writtenPostCount
          : writtenPostCount // ignore: cast_nullable_to_non_nullable
              as int,
      receivedReactionCount: null == receivedReactionCount
          ? _value.receivedReactionCount
          : receivedReactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      successWeekMondayList: null == successWeekMondayList
          ? _value.successWeekMondayList
          : successWeekMondayList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      weeklyPostCountList: null == weeklyPostCountList
          ? _value.weeklyPostCountList
          : weeklyPostCountList // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResolutionEntityImplCopyWith<$Res> implements $ResolutionEntityCopyWith<$Res> {
  factory _$$ResolutionEntityImplCopyWith(_$ResolutionEntityImpl value, $Res Function(_$ResolutionEntityImpl) then) =
      __$$ResolutionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String resolutionId,
      String resolutionName,
      String goalStatement,
      String actionStatement,
      bool isActive,
      int actionPerWeek,
      int colorIndex,
      int iconIndex,
      DateTime startDate,
      List<UserDataEntity> shareFriendEntityList,
      List<GroupEntity> shareGroupEntityList,
      int writtenPostCount,
      int receivedReactionCount,
      List<DateTime> successWeekMondayList,
      List<int> weeklyPostCountList});
}

/// @nodoc
class __$$ResolutionEntityImplCopyWithImpl<$Res> extends _$ResolutionEntityCopyWithImpl<$Res, _$ResolutionEntityImpl>
    implements _$$ResolutionEntityImplCopyWith<$Res> {
  __$$ResolutionEntityImplCopyWithImpl(_$ResolutionEntityImpl _value, $Res Function(_$ResolutionEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResolutionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolutionId = null,
    Object? resolutionName = null,
    Object? goalStatement = null,
    Object? actionStatement = null,
    Object? isActive = null,
    Object? actionPerWeek = null,
    Object? colorIndex = null,
    Object? iconIndex = null,
    Object? startDate = null,
    Object? shareFriendEntityList = null,
    Object? shareGroupEntityList = null,
    Object? writtenPostCount = null,
    Object? receivedReactionCount = null,
    Object? successWeekMondayList = null,
    Object? weeklyPostCountList = null,
  }) {
    return _then(_$ResolutionEntityImpl(
      resolutionId: null == resolutionId
          ? _value.resolutionId
          : resolutionId // ignore: cast_nullable_to_non_nullable
              as String,
      resolutionName: null == resolutionName
          ? _value.resolutionName
          : resolutionName // ignore: cast_nullable_to_non_nullable
              as String,
      goalStatement: null == goalStatement
          ? _value.goalStatement
          : goalStatement // ignore: cast_nullable_to_non_nullable
              as String,
      actionStatement: null == actionStatement
          ? _value.actionStatement
          : actionStatement // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      actionPerWeek: null == actionPerWeek
          ? _value.actionPerWeek
          : actionPerWeek // ignore: cast_nullable_to_non_nullable
              as int,
      colorIndex: null == colorIndex
          ? _value.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int,
      iconIndex: null == iconIndex
          ? _value.iconIndex
          : iconIndex // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shareFriendEntityList: null == shareFriendEntityList
          ? _value._shareFriendEntityList
          : shareFriendEntityList // ignore: cast_nullable_to_non_nullable
              as List<UserDataEntity>,
      shareGroupEntityList: null == shareGroupEntityList
          ? _value._shareGroupEntityList
          : shareGroupEntityList // ignore: cast_nullable_to_non_nullable
              as List<GroupEntity>,
      writtenPostCount: null == writtenPostCount
          ? _value.writtenPostCount
          : writtenPostCount // ignore: cast_nullable_to_non_nullable
              as int,
      receivedReactionCount: null == receivedReactionCount
          ? _value.receivedReactionCount
          : receivedReactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      successWeekMondayList: null == successWeekMondayList
          ? _value._successWeekMondayList
          : successWeekMondayList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      weeklyPostCountList: null == weeklyPostCountList
          ? _value._weeklyPostCountList
          : weeklyPostCountList // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TimestampConverter()
@DocumentReferenceJsonConverter()
class _$ResolutionEntityImpl implements _ResolutionEntity {
  const _$ResolutionEntityImpl(
      {this.resolutionId = '',
      this.resolutionName = '',
      this.goalStatement = '',
      this.actionStatement = '',
      this.isActive = false,
      this.actionPerWeek = 0,
      this.colorIndex = 0,
      this.iconIndex = 0,
      required this.startDate,
      final List<UserDataEntity> shareFriendEntityList = const [],
      final List<GroupEntity> shareGroupEntityList = const [],
      this.writtenPostCount = 0,
      this.receivedReactionCount = 0,
      final List<DateTime> successWeekMondayList = const [],
      final List<int> weeklyPostCountList = const []})
      : _shareFriendEntityList = shareFriendEntityList,
        _shareGroupEntityList = shareGroupEntityList,
        _successWeekMondayList = successWeekMondayList,
        _weeklyPostCountList = weeklyPostCountList;

  factory _$ResolutionEntityImpl.fromJson(Map<String, dynamic> json) => _$$ResolutionEntityImplFromJson(json);

  @override
  @JsonKey()
  final String resolutionId;
  @override
  @JsonKey()
  final String resolutionName;
  @override
  @JsonKey()
  final String goalStatement;
  @override
  @JsonKey()
  final String actionStatement;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int actionPerWeek;
  @override
  @JsonKey()
  final int colorIndex;
  @override
  @JsonKey()
  final int iconIndex;
  @override
  final DateTime startDate;
  final List<UserDataEntity> _shareFriendEntityList;
  @override
  @JsonKey()
  List<UserDataEntity> get shareFriendEntityList {
    if (_shareFriendEntityList is EqualUnmodifiableListView) return _shareFriendEntityList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shareFriendEntityList);
  }

  final List<GroupEntity> _shareGroupEntityList;
  @override
  @JsonKey()
  List<GroupEntity> get shareGroupEntityList {
    if (_shareGroupEntityList is EqualUnmodifiableListView) return _shareGroupEntityList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shareGroupEntityList);
  }

  @override
  @JsonKey()
  final int writtenPostCount;
  @override
  @JsonKey()
  final int receivedReactionCount;
  final List<DateTime> _successWeekMondayList;
  @override
  @JsonKey()
  List<DateTime> get successWeekMondayList {
    if (_successWeekMondayList is EqualUnmodifiableListView) return _successWeekMondayList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_successWeekMondayList);
  }

  final List<int> _weeklyPostCountList;
  @override
  @JsonKey()
  List<int> get weeklyPostCountList {
    if (_weeklyPostCountList is EqualUnmodifiableListView) return _weeklyPostCountList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyPostCountList);
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
            (identical(other.resolutionId, resolutionId) || other.resolutionId == resolutionId) &&
            (identical(other.resolutionName, resolutionName) || other.resolutionName == resolutionName) &&
            (identical(other.goalStatement, goalStatement) || other.goalStatement == goalStatement) &&
            (identical(other.actionStatement, actionStatement) || other.actionStatement == actionStatement) &&
            (identical(other.isActive, isActive) || other.isActive == isActive) &&
            (identical(other.actionPerWeek, actionPerWeek) || other.actionPerWeek == actionPerWeek) &&
            (identical(other.colorIndex, colorIndex) || other.colorIndex == colorIndex) &&
            (identical(other.iconIndex, iconIndex) || other.iconIndex == iconIndex) &&
            (identical(other.startDate, startDate) || other.startDate == startDate) &&
            const DeepCollectionEquality().equals(other._shareFriendEntityList, _shareFriendEntityList) &&
            const DeepCollectionEquality().equals(other._shareGroupEntityList, _shareGroupEntityList) &&
            (identical(other.writtenPostCount, writtenPostCount) || other.writtenPostCount == writtenPostCount) &&
            (identical(other.receivedReactionCount, receivedReactionCount) ||
                other.receivedReactionCount == receivedReactionCount) &&
            const DeepCollectionEquality().equals(other._successWeekMondayList, _successWeekMondayList) &&
            const DeepCollectionEquality().equals(other._weeklyPostCountList, _weeklyPostCountList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ResolutionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResolutionEntityImplCopyWith<_$ResolutionEntityImpl> get copyWith =>
      __$$ResolutionEntityImplCopyWithImpl<_$ResolutionEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResolutionEntityImplToJson(
      this,
    );
  }
}

abstract class _ResolutionEntity implements ResolutionEntity {
  const factory _ResolutionEntity(
      {final String resolutionId,
      final String resolutionName,
      final String goalStatement,
      final String actionStatement,
      final bool isActive,
      final int actionPerWeek,
      final int colorIndex,
      final int iconIndex,
      required final DateTime startDate,
      final List<UserDataEntity> shareFriendEntityList,
      final List<GroupEntity> shareGroupEntityList,
      final int writtenPostCount,
      final int receivedReactionCount,
      final List<DateTime> successWeekMondayList,
      final List<int> weeklyPostCountList}) = _$ResolutionEntityImpl;

  factory _ResolutionEntity.fromJson(Map<String, dynamic> json) = _$ResolutionEntityImpl.fromJson;

  @override
  String get resolutionId;
  @override
  String get resolutionName;
  @override
  String get goalStatement;
  @override
  String get actionStatement;
  @override
  bool get isActive;
  @override
  int get actionPerWeek;
  @override
  int get colorIndex;
  @override
  int get iconIndex;
  @override
  DateTime get startDate;
  @override
  List<UserDataEntity> get shareFriendEntityList;
  @override
  List<GroupEntity> get shareGroupEntityList;
  @override
  int get writtenPostCount;
  @override
  int get receivedReactionCount;
  @override
  List<DateTime> get successWeekMondayList;
  @override
  List<int> get weeklyPostCountList;

  /// Create a copy of ResolutionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResolutionEntityImplCopyWith<_$ResolutionEntityImpl> get copyWith => throw _privateConstructorUsedError;
}
