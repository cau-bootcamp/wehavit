// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReactionEntityImpl _$$ReactionEntityImplFromJson(Map<String, dynamic> json) =>
    _$ReactionEntityImpl(
      confirmPostId: json['confirmPostId'] as String,
      complimenterUid: json['complimenterUid'] as String,
      reactionType: json['reactionType'] as int,
      instantPhotoUrl: json['instantPhotoUrl'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      emoji: (json['emoji'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as int),
          ) ??
          const {},
    );

Map<String, dynamic> _$$ReactionEntityImplToJson(
        _$ReactionEntityImpl instance) =>
    <String, dynamic>{
      'confirmPostId': instance.confirmPostId,
      'complimenterUid': instance.complimenterUid,
      'reactionType': instance.reactionType,
      'instantPhotoUrl': instance.instantPhotoUrl,
      'comment': instance.comment,
      'emoji': instance.emoji,
    };
