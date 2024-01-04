import 'package:wehavit/domain/entities/reaction_model.dart';

abstract class MyLiveWritingRepository {
  MyLiveWritingRepository();

  // update message on live_confirm_posts
  Future<void> updateMessage(
    String message,
  );

  Future<void> updateTitle(
    String title,
  );

  Future<String> updatePostImage(
    String imageFileUrl,
  );

  Stream<List<ReactionModel>> getReactionListStream();

  Future<bool> consumeReaction(
    String reactionId,
  );
}
