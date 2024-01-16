import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

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
    DateTime? startDate,
    List<UserDataEntity>? fanList,
  }) = _ResolutionEntity;

  factory ResolutionEntity.fromJson(Map<String, dynamic> json) =>
      _$ResolutionEntityFromJson(json);
}
