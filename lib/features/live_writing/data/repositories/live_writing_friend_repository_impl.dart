import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/live_writing/domain/repositories/live_writing_friend_repository.dart';

const int friendStateAccepted = 1;

class LiveWritingFriendRepositoryImpl extends LiveWritingFriendRepository {
  LiveWritingFriendRepositoryImpl();

  final livePostDocumentPrefix = 'LIVE-';

  @override
  Future<List<String>> getVisibleFriendEmailList() async {
    final friendsSnapshots = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.friends)
        .get();

    final friendsAccepted = friendsSnapshots.docs.where((data) {
      return data.data()['friendState'] == friendStateAccepted;
    });

    return friendsAccepted.map<String>((data) {
      return data.data()[FirebaseFriendFieldName.friendEmail];
    }).toList();

    // TEST. 임시로 실시간 공유할 친구 두 명 반환
    return ['69dlXoGSBKhzrySuhb8t9MvqzdD3', 'zZaP501Kc8ccUvR9ogPOsjSeD1s2'];
  }

  @override
  Stream<String> getFriendMessageLiveByEmail(String uid) {
    final stream = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc('$livePostDocumentPrefix$uid')
        .snapshots()
        .map((event) => event.data()!['message'] as String);

    return stream;
  }

  @override
  Stream<String> getFriendTitleLiveByEmail(String uid) {
    final stream = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc('$livePostDocumentPrefix$uid')
        .snapshots()
        .map((event) => event.data()!['title'] as String);

    return stream;
  }

  @override
  Future<String> getFriendMessageOnceByEmail(String uid) async {
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc('$livePostDocumentPrefix$uid')
        .get()
        .then(
      (value) {
        return value.data()![FirebaseLiveConfirmPostFieldName.message]
            as String;
      },
    );
  }

  @override
  Future<String> getFriendNameOnceByEmail(String email) {
    final res = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(FirebaseUserFieldName.email, isEqualTo: email)
        .get()
        .then<String>(
      (value) {
        return value.docs.first.data()[FirebaseUserFieldName.displayName];
      },
    );
    return res;
  }
}
