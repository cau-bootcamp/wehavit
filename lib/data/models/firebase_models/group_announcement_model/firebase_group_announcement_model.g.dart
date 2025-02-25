// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_group_announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseGroupAnnouncementModelImpl _$$FirebaseGroupAnnouncementModelImplFromJson(Map<String, dynamic> json) =>
    _$FirebaseGroupAnnouncementModelImpl(
      groupId: json['groupId'] as String,
      writerUid: json['writerUid'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      readByUidList: (json['readByUidList'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$FirebaseGroupAnnouncementModelImplToJson(_$FirebaseGroupAnnouncementModelImpl instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'writerUid': instance.writerUid,
      'title': instance.title,
      'content': instance.content,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'readByUidList': instance.readByUidList,
    };
