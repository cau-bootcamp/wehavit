import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/reaction_model.dart';

abstract class LiveWritingFriendRepository {
  LiveWritingFriendRepository();

  Future<List<String>> getVisibleFriendEmailList();

  Future<String> getFriendProfileImageUrlByEmail(String email);

  Stream<String> getFriendMessageLiveByEmail(String email);

  Stream<String> getFriendTitleLiveByEmail(String email);

  Stream<String> getFriendPostImageLiveByEmail(String email);

  Future<String> getFriendMessageOnceByEmail(String email);

  Future<String> getFriendNameOnceByEmail(String email);

  EitherFuture<bool> sendReactionToTargetFriend(
    String targetEmail,
    ReactionModel reactionModel,
  );
}
