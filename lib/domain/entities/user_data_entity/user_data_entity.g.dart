// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataEntityImpl _$$UserDataEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserDataEntityImpl(
      friendEmail: json['friendEmail'] as String?,
      friendId: json['friendId'] as String?,
      friendName: json['friendName'] as String?,
      friendImageUrl: json['friendImageUrl'] as String?,
    );

Map<String, dynamic> _$$UserDataEntityImplToJson(
        _$UserDataEntityImpl instance) =>
    <String, dynamic>{
      'friendEmail': instance.friendEmail,
      'friendId': instance.friendId,
      'friendName': instance.friendName,
      'friendImageUrl': instance.friendImageUrl,
    };
