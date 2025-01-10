// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_announcement_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupAnnouncementEntityImpl _$$GroupAnnouncementEntityImplFromJson(Map<String, dynamic> json) =>
    _$GroupAnnouncementEntityImpl(
      groupId: json['groupId'] as String,
      writerUid: json['writerUid'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readByUidList: (json['readByUidList'] as List<dynamic>).map((e) => e as String).toList(),
      groupAnnouncementId: json['groupAnnouncementId'] as String,
    );

Map<String, dynamic> _$$GroupAnnouncementEntityImplToJson(_$GroupAnnouncementEntityImpl instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'writerUid': instance.writerUid,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'readByUidList': instance.readByUidList,
    };
