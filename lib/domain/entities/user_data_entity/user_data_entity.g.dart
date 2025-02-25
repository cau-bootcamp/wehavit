// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataEntityImpl _$$UserDataEntityImplFromJson(Map<String, dynamic> json) => _$UserDataEntityImpl(
      handle: json['handle'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      userImageUrl: json['userImageUrl'] as String? ?? '',
      aboutMe: json['aboutMe'] as String? ?? '',
      messageToken: json['messageToken'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      cumulativeGoals: (json['cumulativeGoals'] as num?)?.toInt() ?? 0,
      cumulativePosts: (json['cumulativePosts'] as num?)?.toInt() ?? 0,
      cumulativeReactions: (json['cumulativeReactions'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserDataEntityImplToJson(_$UserDataEntityImpl instance) => <String, dynamic>{
      'handle': instance.handle,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImageUrl': instance.userImageUrl,
      'aboutMe': instance.aboutMe,
      'messageToken': instance.messageToken,
      'createdAt': instance.createdAt.toIso8601String(),
      'cumulativeGoals': instance.cumulativeGoals,
      'cumulativePosts': instance.cumulativePosts,
      'cumulativeReactions': instance.cumulativeReactions,
    };
