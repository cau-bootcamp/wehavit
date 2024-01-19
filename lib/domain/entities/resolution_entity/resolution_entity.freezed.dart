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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResolutionEntity _$ResolutionEntityFromJson(Map<String, dynamic> json) {
  return _ResolutionEntity.fromJson(json);
}

/// @nodoc
mixin _$ResolutionEntity {
  String? get resolutionId => throw _privateConstructorUsedError;
  String? get goalStatement => throw _privateConstructorUsedError;
  String? get actionStatement => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  int? get actionPerWeek => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  List<UserDataEntity>? get fanList => throw _privateConstructorUsedError;

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
      String? goalStatement,
      String? actionStatement,
      bool? isActive,
      int? actionPerWeek,
      DateTime? startDate,
      List<UserDataEntity>? fanList});
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
    Object? goalStatement = freezed,
    Object? actionStatement = freezed,
    Object? isActive = freezed,
    Object? actionPerWeek = freezed,
    Object? startDate = freezed,
    Object? fanList = freezed,
  }) {
    return _then(_value.copyWith(
      resolutionId: freezed == resolutionId
          ? _value.resolutionId
          : resolutionId // ignore: cast_nullable_to_non_nullable
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
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fanList: freezed == fanList
          ? _value.fanList
          : fanList // ignore: cast_nullable_to_non_nullable
              as List<UserDataEntity>?,
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
      String? goalStatement,
      String? actionStatement,
      bool? isActive,
      int? actionPerWeek,
      DateTime? startDate,
      List<UserDataEntity>? fanList});
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
    Object? goalStatement = freezed,
    Object? actionStatement = freezed,
    Object? isActive = freezed,
    Object? actionPerWeek = freezed,
    Object? startDate = freezed,
    Object? fanList = freezed,
  }) {
    return _then(_$ResolutionEntityImpl(
      resolutionId: freezed == resolutionId
          ? _value.resolutionId
          : resolutionId // ignore: cast_nullable_to_non_nullable
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
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fanList: freezed == fanList
          ? _value._fanList
          : fanList // ignore: cast_nullable_to_non_nullable
              as List<UserDataEntity>?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$ResolutionEntityImpl implements _ResolutionEntity {
  const _$ResolutionEntityImpl(
      {this.resolutionId,
      this.goalStatement,
      this.actionStatement,
      this.isActive,
      this.actionPerWeek,
      this.startDate,
      final List<UserDataEntity>? fanList})
      : _fanList = fanList;

  factory _$ResolutionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResolutionEntityImplFromJson(json);

  @override
  final String? resolutionId;
  @override
  final String? goalStatement;
  @override
  final String? actionStatement;
  @override
  final bool? isActive;
  @override
  final int? actionPerWeek;
  @override
  final DateTime? startDate;
  final List<UserDataEntity>? _fanList;
  @override
  List<UserDataEntity>? get fanList {
    final value = _fanList;
    if (value == null) return null;
    if (_fanList is EqualUnmodifiableListView) return _fanList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ResolutionEntity(resolutionId: $resolutionId, goalStatement: $goalStatement, actionStatement: $actionStatement, isActive: $isActive, actionPerWeek: $actionPerWeek, startDate: $startDate, fanList: $fanList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResolutionEntityImpl &&
            (identical(other.resolutionId, resolutionId) ||
                other.resolutionId == resolutionId) &&
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
            const DeepCollectionEquality().equals(other._fanList, _fanList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      resolutionId,
      goalStatement,
      actionStatement,
      isActive,
      actionPerWeek,
      startDate,
      const DeepCollectionEquality().hash(_fanList));

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
      final String? goalStatement,
      final String? actionStatement,
      final bool? isActive,
      final int? actionPerWeek,
      final DateTime? startDate,
      final List<UserDataEntity>? fanList}) = _$ResolutionEntityImpl;

  factory _ResolutionEntity.fromJson(Map<String, dynamic> json) =
      _$ResolutionEntityImpl.fromJson;

  @override
  String? get resolutionId;
  @override
  String? get goalStatement;
  @override
  String? get actionStatement;
  @override
  bool? get isActive;
  @override
  int? get actionPerWeek;
  @override
  DateTime? get startDate;
  @override
  List<UserDataEntity>? get fanList;
  @override
  @JsonKey(ignore: true)
  _$$ResolutionEntityImplCopyWith<_$ResolutionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
