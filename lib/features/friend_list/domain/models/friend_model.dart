import 'package:wehavit/common/constants/firebase_field_name.dart';

class FriendModel {
  FriendModel({
    required this.friendEmail,
    required this.friendName,
    required this.friendImageUrl,
  });

  FriendModel.fromMapData(
    Map<String, dynamic> data,
    Map<String, dynamic> usersData,
  )   : friendEmail = data[FirebaseFriendFieldName.friendEmail],
        friendName = usersData[FirebaseUserFieldName.displayName],
        friendImageUrl = usersData[FirebaseUserFieldName.imageUrl];

  String friendEmail;
  String friendName;
  String friendImageUrl;

  FriendModel copyWith({
    String? friendID,
    String? friendName,
    String? friendImageUrl,
  }) {
    return FriendModel(
      friendEmail: friendID ?? friendEmail,
      friendName: friendName ?? this.friendName,
      friendImageUrl: friendImageUrl ?? this.friendImageUrl,
    );
  }
}
