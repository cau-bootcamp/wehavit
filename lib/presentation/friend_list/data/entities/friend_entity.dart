import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/domain/entities/friend_model.dart';

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
      friendEmail: friendEmail,
      friendName: friendName,
      friendImageUrl: friendImageUrl,
    );
    return model;
  }
}
