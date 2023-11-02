import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';

class FriendModel {
  FriendModel({
    required this.friendName,
    required this.friendImageUrl,
  });

  FriendModel.fromMapData(Map<String, dynamic> data)
      : friendName = data[FirebaseFieldName.displayName],
        friendImageUrl = data[FirebaseFieldName.imageUrl];

  String friendName;
  String friendImageUrl;

  FriendModel copyWith({
    String? friendName,
    String? friendImageUrl,
  }) {
    return FriendModel(
      friendName: friendName ?? this.friendName,
      friendImageUrl: friendImageUrl ?? this.friendImageUrl,
    );
  }
}
