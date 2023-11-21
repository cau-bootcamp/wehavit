import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

abstract class LiveWritingFriendRepository {
  LiveWritingFriendRepository();

  Future<List<String>> getVisibleFriendEmailList();

  Stream<String> getFriendMessageLiveByEmail(String email);

  Stream<String> getFriendTitleLiveByEmail(String email);

  Future<String> getFriendMessageOnceByEmail(String email);

  Future<String> getFriendNameOnceByEmail(String email);

  EitherFuture<bool> sendReactionToTargetFriend(
    String targetEmail,
    ReactionModel reactionModel,
  );
}
