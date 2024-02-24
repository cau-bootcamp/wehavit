import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'resolution_entity.freezed.dart';
part 'resolution_entity.g.dart';

@freezed
class ResolutionEntity with _$ResolutionEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  const factory ResolutionEntity({
    String? resolutionId,
    String? goalStatement,
    String? actionStatement,
    bool? isActive,
    int? actionPerWeek,
    int? colorIndex,
    DateTime? startDate,
    List<UserDataEntity>? shareFriendEntityList,
    List<GroupEntity>? shareGroupEntityList,
  }) = _ResolutionEntity;

  factory ResolutionEntity.fromJson(Map<String, dynamic> json) =>
      _$ResolutionEntityFromJson(json);
}
