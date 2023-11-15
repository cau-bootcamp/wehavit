abstract class LiveWritingFriendRepository {
  LiveWritingFriendRepository();

  Future<List<String>> getVisibleFriendEmailList();

  Stream<String> getFriendMessageLiveByEmail(String email);

  Stream<String> getFriendTitleLiveByEmail(String email);

  Future<String> getFriendMessageOnceByEmail(String email);

  Future<String> getFriendNameOnceByEmail(String email);
}
