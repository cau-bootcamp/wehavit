// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReactionModelImpl _$$ReactionModelImplFromJson(Map<String, dynamic> json) =>
    _$ReactionModelImpl(
      complimenterUid: json['complimenterUid'] as String,
      reactionType: json['reactionType'] as int,
      hasRead: json['hasRead'] as bool? ?? false,
      instantPhotoUrl: json['instantPhotoUrl'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      emoji: (json['emoji'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as int),
          ) ??
          const {},
    );

Map<String, dynamic> _$$ReactionModelImplToJson(_$ReactionModelImpl instance) =>
    <String, dynamic>{
      'complimenterUid': instance.complimenterUid,
      'reactionType': instance.reactionType,
      'hasRead': instance.hasRead,
      'instantPhotoUrl': instance.instantPhotoUrl,
      'comment': instance.comment,
      'emoji': instance.emoji,
    };
