abstract class NotificationRepository {
  Future<void> sendNotification({
    required String title,
    required String content,
    required List<String> targetTokenList,
  });
}
