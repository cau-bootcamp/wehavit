abstract class LiveWritingPostRepository {
  LiveWritingPostRepository();

  // update message on live_confirm_posts
  Future<void> updateMessage(
    String message,
  );

  Future<void> updateTitle(
    String title,
  );
}
