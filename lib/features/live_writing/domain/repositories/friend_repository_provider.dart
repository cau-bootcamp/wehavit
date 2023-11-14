import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_repository_provider.g.dart';

class FriendRepository {
  FriendRepository();

  Future<List<String>> getVisibleFriends() async {
    return ['69dlXoGSBKhzrySuhb8t9MvqzdD3', 'zZaP501Kc8ccUvR9ogPOsjSeD1s2'];
  }

  Stream<String> getFriendMessageByUid(String uid) {
    final stream = FirebaseFirestore.instance
        .collection('live_confirm_posts')
        .where(
          'userId',
          isEqualTo: uid,
        )
        .snapshots()
        .map((event) => event.docs.first.data()['message'] as String);

    return stream;
  }

  Stream<String> getFriendTitleByUid(String uid) {
    final stream = FirebaseFirestore.instance
        .collection('live_confirm_posts')
        .where(
          'userId',
          isEqualTo: uid,
        )
        .snapshots()
        .map((event) => event.docs.first.data()['title'] as String);

    return stream;
  }

  Future<String> getFriendMessageByUidOnce(String uid) async {
    return FirebaseFirestore.instance
        .collection('live_confirm_posts')
        .where(
          'userId',
          isEqualTo: uid,
        )
        .get()
        .then(
      (value) {
        if (value.docs.isEmpty) {
          return '참여하지 않은 사용자입니다';
        }
        return value.docs.first.data()['message'] as String;
      },
    );
  }

  Future<String> getFriendNameByUid(String uid) async {
    return FirebaseFirestore.instance.collection('users').doc(uid).get().then(
      (value) {
        return value.data()!['displayName'] as String;
      },
    );
  }
}

@riverpod
FriendRepository getFriendRepository(GetFriendRepositoryRef ref) =>
    FriendRepository();
