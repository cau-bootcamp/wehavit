import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';

class FriendModel {
  FriendModel({
    required this.friendID,
    required this.friendName,
    required this.friendImageUrl,
  });

  FriendModel.fromMapData(Map<String, dynamic> data)
      : friendID = data[FirebaseFieldName.friendID],
        friendName = data[FirebaseFieldName.friendName],
        friendImageUrl = data[FirebaseFieldName.friendImageUrl];

  String friendID;
  String friendName;
  String friendImageUrl;

  FriendModel copyWith({
    String? friendID,
    String? friendName,
    String? friendImageUrl,
  }) {
    return FriendModel(
      friendID: friendID ?? this.friendID,
      friendName: friendName ?? this.friendName,
      friendImageUrl: friendImageUrl ?? this.friendImageUrl,
    );
  }
}
