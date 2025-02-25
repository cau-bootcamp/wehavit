import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'resolution_entity.freezed.dart';
part 'resolution_entity.g.dart';

@freezed
class ResolutionEntity with _$ResolutionEntity {
  // ignore: invalid_annotation_target
  @TimestampConverter()
  @DocumentReferenceJsonConverter()
  const factory ResolutionEntity({
    @Default('') String resolutionId,
    @Default('') String resolutionName,
    @Default('') String goalStatement,
    @Default('') String actionStatement,
    @Default(false) bool isActive,
    @Default(0) int actionPerWeek,
    @Default(0) int colorIndex,
    @Default(0) int iconIndex,
    required DateTime startDate,
    @Default([]) List<UserDataEntity> shareFriendEntityList,
    @Default([]) List<GroupEntity> shareGroupEntityList,
    @Default(0) int writtenPostCount,
    @Default(0) int receivedReactionCount,
    @Default([]) List<DateTime> successWeekMondayList,
    @Default([]) List<int> weeklyPostCountList,
  }) = _ResolutionEntity;

  factory ResolutionEntity.fromJson(Map<String, dynamic> json) => _$ResolutionEntityFromJson(json);
}
