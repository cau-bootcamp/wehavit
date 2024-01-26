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
      groupMembers: (json['groupMembers'] as List<dynamic>)
          .map((e) => UserDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FirebaseGroupModelImplToJson(
        _$FirebaseGroupModelImpl instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'groupDescription': instance.groupDescription,
      'groupRule': instance.groupRule,
      'groupManagerUid': instance.groupManagerUid,
      'groupMembers': instance.groupMembers,
    };
