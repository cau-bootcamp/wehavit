// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReactionModelImpl _$$ReactionModelImplFromJson(Map<String, dynamic> json) =>
    _$ReactionModelImpl(
      complementerUid: json['complementerUid'] as String,
      hasRead: json['hasRead'] as bool,
      instantPhotoUrl: json['instantPhotoUrl'] as String,
      reactionType: json['reactionType'] as int,
      comment: json['comment'] as String,
      emoji: Map<String, int>.from(json['emoji'] as Map),
    );

Map<String, dynamic> _$$ReactionModelImplToJson(_$ReactionModelImpl instance) =>
    <String, dynamic>{
      'complementerUid': instance.complementerUid,
      'hasRead': instance.hasRead,
      'instantPhotoUrl': instance.instantPhotoUrl,
      'reactionType': instance.reactionType,
      'comment': instance.comment,
      'emoji': instance.emoji,
    };
