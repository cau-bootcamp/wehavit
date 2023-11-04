import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';
import 'package:wehavit/features/friend_list/domain/models/add_friend_model.dart';

class FriendEntity {
  FriendEntity.fromFirebaseDocument(Map<String, dynamic> data, Map<String, dynamic> usersData)
      : friendID = data[FirebaseFieldName.friendID],
        friendName = usersData[FirebaseFieldName.displayName],
        friendImageUrl = usersData[FirebaseFieldName.imageUrl];
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

    doc[FirebaseFieldName.friendID] = friendID;

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