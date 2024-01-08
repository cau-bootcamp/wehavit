import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';

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

  Stream<List<ReactionEntity>> getReactionListStream();

  Future<bool> consumeReaction(
    String reactionId,
  );
}
