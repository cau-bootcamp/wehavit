import 'package:flutter/foundation.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/effects/emojis/shoot_emoji_widget.dart';

class SendReactionStateModel {
  SendReactionStateModel(this.myUserDataEntity, this.confirmPostEntity);

  // from
  UserDataEntity? myUserDataEntity;

  // target
  ConfirmPostEntity? confirmPostEntity;

  // Comment Reaction
  String sendingComment = '';

  // Emoji Reaction UI Variables
  Map<Key, ShootEmojiWidget> emojiWidgets = {};
  List<int> sendingEmojis = List<int>.generate(15, (index) => 0);
  int get emojiSendCount => sendingEmojis.reduce((v, e) => v + e);

  // Quickshot Reaction
  String sendingQuickshotUrl = '';
}
