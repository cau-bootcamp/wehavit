// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseGroupModelImpl _$$FirebaseGroupModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FirebaseGroupModelImpl(
      groupName: json['groupName'] as String,
      groupDescription: json['groupDescription'] as String,
      groupRule: json['groupRule'] as String,
      groupManagerUid: json['groupManagerUid'] as String,
      groupColor: json['groupColor'] as int,
      groupMemberUidList: (json['groupMemberUidList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      groupCreatedAt: const TimestampConverter()
          .fromJson(json['groupCreatedAt'] as Timestamp),
    );

Map<String, dynamic> _$$FirebaseGroupModelImplToJson(
        _$FirebaseGroupModelImpl instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'groupDescription': instance.groupDescription,
      'groupRule': instance.groupRule,
      'groupManagerUid': instance.groupManagerUid,
      'groupColor': instance.groupColor,
      'groupMemberUidList': instance.groupMemberUidList,
      'groupCreatedAt':
          const TimestampConverter().toJson(instance.groupCreatedAt),
    };
