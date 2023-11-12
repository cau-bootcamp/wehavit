import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';
import 'package:wehavit/features/friend_list/domain/models/add_friend_model.dart';

class FriendEntity {
  FriendEntity.fromFirebaseDocument(String id, Map<String, dynamic> data)
      : friendID = id,
        friendName = data[FirebaseUserFieldName.displayName],
        friendImageUrl = data[FirebaseUserFieldName.imageUrl];
  FriendEntity.fromFriendModel(AddFriendModel model) {
    friendID = model.friendID;
  }

  late String friendID;
  late String friendName;
  late String friendImageUrl;
}

extension FriendEntityConvertFunctions on FriendEntity {
  Map<String, dynamic> toFirebaseDocument() {
    final Map<String, dynamic> doc = {};

    doc[FirebaseFriendFieldName.friendID] = friendID;

    return doc;
  }

  FriendModel toFriendModel() {
    final model = FriendModel(
      friendID: friendID,
      friendName: friendName,
      friendImageUrl: friendImageUrl,
    );
    return model;
  }
}
