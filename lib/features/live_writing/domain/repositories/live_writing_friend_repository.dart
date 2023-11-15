abstract class LiveWritingFriendRepository {
  LiveWritingFriendRepository();

  Future<List<String>> getVisibleFriendEmails();

  Stream<String> getFriendMessageLiveByUid(String uid);

  Stream<String> getFriendTitleLiveByUid(String uid);

  Future<String> getFriendMessageOnceByUid(String uid);

  Future<String> getFriendNameOnceByUid(String uid);
}
