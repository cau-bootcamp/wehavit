// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupEntityImpl _$$GroupEntityImplFromJson(Map<String, dynamic> json) =>
    _$GroupEntityImpl(
      groupName: json['groupName'] as String,
      groupDescription: json['groupDescription'] as String? ?? '',
      groupRule: json['groupRule'] as String? ?? '',
      groupManagerUid: json['groupManagerUid'] as String,
      groupMemberUidList: (json['groupMemberUidList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      groupId: json['groupId'] as String,
    );

Map<String, dynamic> _$$GroupEntityImplToJson(_$GroupEntityImpl instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'groupDescription': instance.groupDescription,
      'groupRule': instance.groupRule,
      'groupManagerUid': instance.groupManagerUid,
      'groupMemberUidList': instance.groupMemberUidList,
    };
