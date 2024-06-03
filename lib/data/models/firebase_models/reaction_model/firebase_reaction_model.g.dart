// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_reaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseReactionModelImpl _$$FirebaseReactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FirebaseReactionModelImpl(
      complimenterUid: json['complimenterUid'] as String,
      reactionType: (json['reactionType'] as num).toInt(),
      quickShotUrl: json['quickShotUrl'] as String,
      comment: json['comment'] as String,
      emoji: Map<String, int>.from(json['emoji'] as Map),
    );

Map<String, dynamic> _$$FirebaseReactionModelImplToJson(
        _$FirebaseReactionModelImpl instance) =>
    <String, dynamic>{
      'complimenterUid': instance.complimenterUid,
      'reactionType': instance.reactionType,
      'quickShotUrl': instance.quickShotUrl,
      'comment': instance.comment,
      'emoji': instance.emoji,
    };
