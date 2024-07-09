// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_resolution_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FirebaseResolutionModel _$FirebaseResolutionModelFromJson(
    Map<String, dynamic> json) {
  return _FirebaseResolutionModel.fromJson(json);
}

/// @nodoc
mixin _$FirebaseResolutionModel {
  String? get resolutionName => throw _privateConstructorUsedError;
  String? get goalStatement => throw _privateConstructorUsedError;
  String? get actionStatement => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  int? get colorIndex => throw _privateConstructorUsedError;
  int? get iconIndex => throw _privateConstructorUsedError;
  int? get actionPerWeek => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get startDate => throw _privateConstructorUsedError;
  List<String>? get shareFriendIdList => throw _privateConstructorUsedError;
  List<String>? get shareGroupIdList => throw _privateConstructorUsedError;
  int? get writtenPostCount => throw _privateConstructorUsedError;
  int? get receivedReactionCount => throw _privateConstructorUsedError;
  @TimestampConverter()
  List<DateTime>? get successWeekMondayList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebaseResolutionModelCopyWith<FirebaseResolutionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseResolutionModelCopyWith<$Res> {
  factory $FirebaseResolutionModelCopyWith(FirebaseResolutionModel value,
          $Res Function(FirebaseResolutionModel) then) =
      _$FirebaseResolutionModelCopyWithImpl<$Res, FirebaseResolutionModel>;
  @useResult
  $Res call(
      {String? resolutionName,
      String? goalStatement,
      String? actionStatement,
      bool? isActive,
      int? colorIndex,
      int? iconIndex,
      int? actionPerWeek,
      @TimestampConverter() DateTime? startDate,
      List<String>? shareFriendIdList,
      List<String>? shareGroupIdList,
      int? writtenPostCount,
      int? receivedReactionCount,
      @TimestampConverter() List<DateTime>? successWeekMondayList});
}

/// @nodoc
class _$FirebaseResolutionModelCopyWithImpl<$Res,
        $Val extends FirebaseResolutionModel>
    implements $FirebaseResolutionModelCopyWith<$Res> {
  _$FirebaseResolutionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolutionName = freezed,
    Object? goalStatement = freezed,
    Object? actionStatement = freezed,
    Object? isActive = freezed,
    Object? colorIndex = freezed,
    Object? iconIndex = freezed,
    Object? actionPerWeek = freezed,
    Object? startDate = freezed,
    Object? shareFriendIdList = freezed,
    Object? shareGroupIdList = freezed,
    Object? writtenPostCount = freezed,
    Object? receivedReactionCount = freezed,
    Object? successWeekMondayList = freezed,
  }) {
    return _then(_value.copyWith(
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
      colorIndex: freezed == colorIndex
          ? _value.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      iconIndex: freezed == iconIndex
          ? _value.iconIndex
          : iconIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      actionPerWeek: freezed == actionPerWeek
          ? _value.actionPerWeek
          : actionPerWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shareFriendIdList: freezed == shareFriendIdList
          ? _value.shareFriendIdList
          : shareFriendIdList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      shareGroupIdList: freezed == shareGroupIdList
          ? _value.shareGroupIdList
          : shareGroupIdList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirebaseResolutionModelImplCopyWith<$Res>
    implements $FirebaseResolutionModelCopyWith<$Res> {
  factory _$$FirebaseResolutionModelImplCopyWith(
          _$FirebaseResolutionModelImpl value,
          $Res Function(_$FirebaseResolutionModelImpl) then) =
      __$$FirebaseResolutionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? resolutionName,
      String? goalStatement,
      String? actionStatement,
      bool? isActive,
      int? colorIndex,
      int? iconIndex,
      int? actionPerWeek,
      @TimestampConverter() DateTime? startDate,
      List<String>? shareFriendIdList,
      List<String>? shareGroupIdList,
      int? writtenPostCount,
      int? receivedReactionCount,
      @TimestampConverter() List<DateTime>? successWeekMondayList});
}

/// @nodoc
class __$$FirebaseResolutionModelImplCopyWithImpl<$Res>
    extends _$FirebaseResolutionModelCopyWithImpl<$Res,
        _$FirebaseResolutionModelImpl>
    implements _$$FirebaseResolutionModelImplCopyWith<$Res> {
  __$$FirebaseResolutionModelImplCopyWithImpl(
      _$FirebaseResolutionModelImpl _value,
      $Res Function(_$FirebaseResolutionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolutionName = freezed,
    Object? goalStatement = freezed,
    Object? actionStatement = freezed,
    Object? isActive = freezed,
    Object? colorIndex = freezed,
    Object? iconIndex = freezed,
    Object? actionPerWeek = freezed,
    Object? startDate = freezed,
    Object? shareFriendIdList = freezed,
    Object? shareGroupIdList = freezed,
    Object? writtenPostCount = freezed,
    Object? receivedReactionCount = freezed,
    Object? successWeekMondayList = freezed,
  }) {
    return _then(_$FirebaseResolutionModelImpl(
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
      colorIndex: freezed == colorIndex
          ? _value.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      iconIndex: freezed == iconIndex
          ? _value.iconIndex
          : iconIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      actionPerWeek: freezed == actionPerWeek
          ? _value.actionPerWeek
          : actionPerWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shareFriendIdList: freezed == shareFriendIdList
          ? _value._shareFriendIdList
          : shareFriendIdList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      shareGroupIdList: freezed == shareGroupIdList
          ? _value._shareGroupIdList
          : shareGroupIdList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$FirebaseResolutionModelImpl implements _FirebaseResolutionModel {
  const _$FirebaseResolutionModelImpl(
      {required this.resolutionName,
      required this.goalStatement,
      required this.actionStatement,
      required this.isActive,
      required this.colorIndex,
      required this.iconIndex,
      required this.actionPerWeek,
      @TimestampConverter() required this.startDate,
      required final List<String>? shareFriendIdList,
      required final List<String>? shareGroupIdList,
      required this.writtenPostCount,
      required this.receivedReactionCount,
      @TimestampConverter()
      required final List<DateTime>? successWeekMondayList})
      : _shareFriendIdList = shareFriendIdList,
        _shareGroupIdList = shareGroupIdList,
        _successWeekMondayList = successWeekMondayList;

  factory _$FirebaseResolutionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirebaseResolutionModelImplFromJson(json);

  @override
  final String? resolutionName;
  @override
  final String? goalStatement;
  @override
  final String? actionStatement;
  @override
  final bool? isActive;
  @override
  final int? colorIndex;
  @override
  final int? iconIndex;
  @override
  final int? actionPerWeek;
  @override
  @TimestampConverter()
  final DateTime? startDate;
  final List<String>? _shareFriendIdList;
  @override
  List<String>? get shareFriendIdList {
    final value = _shareFriendIdList;
    if (value == null) return null;
    if (_shareFriendIdList is EqualUnmodifiableListView)
      return _shareFriendIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _shareGroupIdList;
  @override
  List<String>? get shareGroupIdList {
    final value = _shareGroupIdList;
    if (value == null) return null;
    if (_shareGroupIdList is EqualUnmodifiableListView)
      return _shareGroupIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? writtenPostCount;
  @override
  final int? receivedReactionCount;
  final List<DateTime>? _successWeekMondayList;
  @override
  @TimestampConverter()
  List<DateTime>? get successWeekMondayList {
    final value = _successWeekMondayList;
    if (value == null) return null;
    if (_successWeekMondayList is EqualUnmodifiableListView)
      return _successWeekMondayList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FirebaseResolutionModel(resolutionName: $resolutionName, goalStatement: $goalStatement, actionStatement: $actionStatement, isActive: $isActive, colorIndex: $colorIndex, iconIndex: $iconIndex, actionPerWeek: $actionPerWeek, startDate: $startDate, shareFriendIdList: $shareFriendIdList, shareGroupIdList: $shareGroupIdList, writtenPostCount: $writtenPostCount, receivedReactionCount: $receivedReactionCount, successWeekMondayList: $successWeekMondayList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirebaseResolutionModelImpl &&
            (identical(other.resolutionName, resolutionName) ||
                other.resolutionName == resolutionName) &&
            (identical(other.goalStatement, goalStatement) ||
                other.goalStatement == goalStatement) &&
            (identical(other.actionStatement, actionStatement) ||
                other.actionStatement == actionStatement) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.colorIndex, colorIndex) ||
                other.colorIndex == colorIndex) &&
            (identical(other.iconIndex, iconIndex) ||
                other.iconIndex == iconIndex) &&
            (identical(other.actionPerWeek, actionPerWeek) ||
                other.actionPerWeek == actionPerWeek) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            const DeepCollectionEquality()
                .equals(other._shareFriendIdList, _shareFriendIdList) &&
            const DeepCollectionEquality()
                .equals(other._shareGroupIdList, _shareGroupIdList) &&
            (identical(other.writtenPostCount, writtenPostCount) ||
                other.writtenPostCount == writtenPostCount) &&
            (identical(other.receivedReactionCount, receivedReactionCount) ||
                other.receivedReactionCount == receivedReactionCount) &&
            const DeepCollectionEquality()
                .equals(other._successWeekMondayList, _successWeekMondayList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      resolutionName,
      goalStatement,
      actionStatement,
      isActive,
      colorIndex,
      iconIndex,
      actionPerWeek,
      startDate,
      const DeepCollectionEquality().hash(_shareFriendIdList),
      const DeepCollectionEquality().hash(_shareGroupIdList),
      writtenPostCount,
      receivedReactionCount,
      const DeepCollectionEquality().hash(_successWeekMondayList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirebaseResolutionModelImplCopyWith<_$FirebaseResolutionModelImpl>
      get copyWith => __$$FirebaseResolutionModelImplCopyWithImpl<
          _$FirebaseResolutionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirebaseResolutionModelImplToJson(
      this,
    );
  }
}

abstract class _FirebaseResolutionModel implements FirebaseResolutionModel {
  const factory _FirebaseResolutionModel(
          {required final String? resolutionName,
          required final String? goalStatement,
          required final String? actionStatement,
          required final bool? isActive,
          required final int? colorIndex,
          required final int? iconIndex,
          required final int? actionPerWeek,
          @TimestampConverter() required final DateTime? startDate,
          required final List<String>? shareFriendIdList,
          required final List<String>? shareGroupIdList,
          required final int? writtenPostCount,
          required final int? receivedReactionCount,
          @TimestampConverter()
          required final List<DateTime>? successWeekMondayList}) =
      _$FirebaseResolutionModelImpl;

  factory _FirebaseResolutionModel.fromJson(Map<String, dynamic> json) =
      _$FirebaseResolutionModelImpl.fromJson;

  @override
  String? get resolutionName;
  @override
  String? get goalStatement;
  @override
  String? get actionStatement;
  @override
  bool? get isActive;
  @override
  int? get colorIndex;
  @override
  int? get iconIndex;
  @override
  int? get actionPerWeek;
  @override
  @TimestampConverter()
  DateTime? get startDate;
  @override
  List<String>? get shareFriendIdList;
  @override
  List<String>? get shareGroupIdList;
  @override
  int? get writtenPostCount;
  @override
  int? get receivedReactionCount;
  @override
  @TimestampConverter()
  List<DateTime>? get successWeekMondayList;
  @override
  @JsonKey(ignore: true)
  _$$FirebaseResolutionModelImplCopyWith<_$FirebaseResolutionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
