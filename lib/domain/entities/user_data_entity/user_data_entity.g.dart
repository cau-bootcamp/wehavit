// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataEntityImpl _$$UserDataEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserDataEntityImpl(
      userEmail: json['userEmail'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userImageUrl: json['userImageUrl'] as String?,
      aboutMe: json['aboutMe'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      cumulativeGoals: json['cumulativeGoals'] as int?,
      cumulativePosts: json['cumulativePosts'] as int?,
      cumulativeReactions: json['cumulativeReactions'] as int?,
    );

Map<String, dynamic> _$$UserDataEntityImplToJson(
        _$UserDataEntityImpl instance) =>
    <String, dynamic>{
      'userEmail': instance.userEmail,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImageUrl': instance.userImageUrl,
      'aboutMe': instance.aboutMe,
      'createdAt': instance.createdAt?.toIso8601String(),
      'cumulativeGoals': instance.cumulativeGoals,
      'cumulativePosts': instance.cumulativePosts,
      'cumulativeReactions': instance.cumulativeReactions,
    };
