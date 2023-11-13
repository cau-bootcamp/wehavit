import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';

class FriendEntity {
  FriendEntity.fromFirebaseDocument(Map<String, dynamic> data)
      : friendEmail = data[FirebaseUserFieldName.email],
        friendName = data[FirebaseUserFieldName.displayName],
        friendImageUrl = data[FirebaseUserFieldName.imageUrl];

  late String friendEmail;
  late String friendName;
  late String friendImageUrl;
}

extension FriendEntityConvertFunctions on FriendEntity {
  FriendModel toFriendModel() {
    final model = FriendModel(
      friendID: friendEmail,
      friendName: friendName,
      friendImageUrl: friendImageUrl,
    );
    return model;
  }
}
