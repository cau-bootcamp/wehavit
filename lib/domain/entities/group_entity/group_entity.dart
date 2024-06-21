// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_entity.freezed.dart';
part 'group_entity.g.dart';

@freezed
class GroupEntity with _$GroupEntity {
  @JsonSerializable()
  factory GroupEntity({
    required String groupName,
    @Default('') String? groupDescription,
    @Default('') String? groupRule,
    required String groupManagerUid,
    required List<String> groupMemberUidList,
    required DateTime groupCreatedAt,
    required int groupColor,
    @JsonKey(includeFromJson: true, includeToJson: false)
    required String groupId,
  }) = _GroupEntity;

  factory GroupEntity.fromJson(Map<String, dynamic> json) =>
      _$GroupEntityFromJson(json);

  static GroupEntity dummy = GroupEntity(
    groupName: 'dummy name',
    groupManagerUid: '',
    groupMemberUidList: [],
    groupCreatedAt: DateTime.now(),
    groupColor: 0,
    groupId: '',
  );
}
