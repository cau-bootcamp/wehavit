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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirebaseResolutionModel _$FirebaseResolutionModelFromJson(
    Map<String, dynamic> json) {
  return _FirebaseResolutionModel.fromJson(json);
}

/// @nodoc
mixin _$FirebaseResolutionModel {
  String? get goalStatement => throw _privateConstructorUsedError;
  String? get actionStatement => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  int? get actionPerWeek => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get startDate => throw _privateConstructorUsedError;
  List<String>? get shareFriendIdList => throw _privateConstructorUsedError;
  List<String>? get shareGroupIdList => throw _privateConstructorUsedError;

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
      {String? goalStatement,
      String? actionStatement,
      bool? isActive,
      int? actionPerWeek,
      @TimestampConverter() DateTime? startDate,
      List<String>? shareFriendIdList,
      List<String>? shareGroupIdList});
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
    Object? goalStatement = freezed,
    Object? actionStatement = freezed,
    Object? isActive = freezed,
    Object? actionPerWeek = freezed,
    Object? startDate = freezed,
    Object? shareFriendIdList = freezed,
    Object? shareGroupIdList = freezed,
  }) {
    return _then(_value.copyWith(
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
      {String? goalStatement,
      String? actionStatement,
      bool? isActive,
      int? actionPerWeek,
      @TimestampConverter() DateTime? startDate,
      List<String>? shareFriendIdList,
      List<String>? shareGroupIdList});
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
    Object? goalStatement = freezed,
    Object? actionStatement = freezed,
    Object? isActive = freezed,
    Object? actionPerWeek = freezed,
    Object? startDate = freezed,
    Object? shareFriendIdList = freezed,
    Object? shareGroupIdList = freezed,
  }) {
    return _then(_$FirebaseResolutionModelImpl(
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
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$FirebaseResolutionModelImpl implements _FirebaseResolutionModel {
  const _$FirebaseResolutionModelImpl(
      {required this.goalStatement,
      required this.actionStatement,
      required this.isActive,
      required this.actionPerWeek,
      @TimestampConverter() required this.startDate,
      required final List<String>? shareFriendIdList,
      required final List<String>? shareGroupIdList})
      : _shareFriendIdList = shareFriendIdList,
        _shareGroupIdList = shareGroupIdList;

  factory _$FirebaseResolutionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirebaseResolutionModelImplFromJson(json);

  @override
  final String? goalStatement;
  @override
  final String? actionStatement;
  @override
  final bool? isActive;
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
  String toString() {
    return 'FirebaseResolutionModel(goalStatement: $goalStatement, actionStatement: $actionStatement, isActive: $isActive, actionPerWeek: $actionPerWeek, startDate: $startDate, shareFriendIdList: $shareFriendIdList, shareGroupIdList: $shareGroupIdList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirebaseResolutionModelImpl &&
            (identical(other.goalStatement, goalStatement) ||
                other.goalStatement == goalStatement) &&
            (identical(other.actionStatement, actionStatement) ||
                other.actionStatement == actionStatement) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.actionPerWeek, actionPerWeek) ||
                other.actionPerWeek == actionPerWeek) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            const DeepCollectionEquality()
                .equals(other._shareFriendIdList, _shareFriendIdList) &&
            const DeepCollectionEquality()
                .equals(other._shareGroupIdList, _shareGroupIdList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      goalStatement,
      actionStatement,
      isActive,
      actionPerWeek,
      startDate,
      const DeepCollectionEquality().hash(_shareFriendIdList),
      const DeepCollectionEquality().hash(_shareGroupIdList));

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
          {required final String? goalStatement,
          required final String? actionStatement,
          required final bool? isActive,
          required final int? actionPerWeek,
          @TimestampConverter() required final DateTime? startDate,
          required final List<String>? shareFriendIdList,
          required final List<String>? shareGroupIdList}) =
      _$FirebaseResolutionModelImpl;

  factory _FirebaseResolutionModel.fromJson(Map<String, dynamic> json) =
      _$FirebaseResolutionModelImpl.fromJson;

  @override
  String? get goalStatement;
  @override
  String? get actionStatement;
  @override
  bool? get isActive;
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
  @JsonKey(ignore: true)
  _$$FirebaseResolutionModelImplCopyWith<_$FirebaseResolutionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
