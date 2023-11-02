import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';

class FriendEntity {
  FriendEntity.fromFirebaseDocument(Map<String, dynamic> data)
      : friendName = data[FirebaseFieldName.friendName],
        friendImageUrl = data[FirebaseFieldName.friendImageUrl];

  FriendEntity.fromFriendModel(FriendModel model) {
    friendName = model.friendName;
    friendImageUrl = model.friendImageUrl;
  }

  late String friendName;
  late String friendImageUrl;
}

extension FriendEntityConvertFunctions on FriendEntity {
  /// Firebase Document로 Entity를 변환
  Map<String, dynamic> toFirebaseDocument() {
    final Map<String, dynamic> doc = {};

    doc[FirebaseFieldName.friendName] = friendName;
    doc[FirebaseFieldName.friendImageUrl] = friendImageUrl;

    return doc;
  }

  FriendModel toFriendModel() {
    final model = FriendModel(
      friendName: friendName,
      friendImageUrl: friendImageUrl,
    );
    return model;
  }
}