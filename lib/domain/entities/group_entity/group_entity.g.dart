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
      groupMembers: (json['groupMembers'] as List<dynamic>)
          .map((e) => UserDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupId: json['groupId'] as String,
    );

Map<String, dynamic> _$$GroupEntityImplToJson(_$GroupEntityImpl instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'groupDescription': instance.groupDescription,
      'groupRule': instance.groupRule,
      'groupManagerUid': instance.groupManagerUid,
      'groupMembers': instance.groupMembers,
      'groupId': instance.groupId,
    };
