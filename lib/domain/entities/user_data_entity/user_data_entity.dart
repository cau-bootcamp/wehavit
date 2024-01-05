import 'package:wehavit/common/constants/firebase_field_name.dart';

class UserDataEntity {
  UserDataEntity({
    this.friendEmail,
    this.friendId,
    this.friendName,
    this.friendImageUrl,
  });

  String? friendEmail;
  String? friendId;
  String? friendName;
  String? friendImageUrl;

  // TODO: Friend Model 생성 시점에 FriendId
  UserDataEntity.fromMapData(
    Map<String, dynamic> data,
    Map<String, dynamic> usersData,
  )   : friendEmail = data[FirebaseFriendFieldName.friendEmail],
        friendName = usersData[FirebaseUserFieldName.displayName],
        friendImageUrl = usersData[FirebaseUserFieldName.imageUrl];

  UserDataEntity copyWith({
    String? friendId,
    String? friendName,
    String? friendImageUrl,
    String? friendEmail,
  }) {
    return UserDataEntity(
      friendId: friendId ?? this.friendId,
      friendEmail: friendEmail ?? this.friendEmail,
      friendName: friendName ?? this.friendName,
      friendImageUrl: friendImageUrl ?? this.friendImageUrl,
    );
  }
}
