import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

abstract class MyLiveWritingRepository {
  MyLiveWritingRepository();

  // update message on live_confirm_posts
  Future<void> updateMessage(
    String message,
  );

  Future<void> updateTitle(
    String title,
  );

  Stream<List<ReactionModel>> getReactionListStream();

  Future<bool> consumeReaction(
    String reactionId,
  );
}
