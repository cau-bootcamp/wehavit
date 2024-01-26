import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'group_entity.freezed.dart';
part 'group_entity.g.dart';

@freezed
class GroupEntity with _$GroupEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  factory GroupEntity({
    required String groupName,
    @Default('') String? groupDescription,
    @Default('') String? groupRule,
    required String groupManagerUid,
    required List<String> groupMemberUid,
    required String groupId,
  }) = _GroupEntity;

  factory GroupEntity.fromJson(Map<String, dynamic> json) =>
      _$GroupEntityFromJson(json);
}
