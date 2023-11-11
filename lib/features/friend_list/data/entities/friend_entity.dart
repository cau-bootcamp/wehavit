import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';

class FriendEntity {
  FriendEntity.fromFirebaseDocument(String id, Map<String, dynamic> data)
      : friendID = id,
        friendName = data[FirebaseFieldName.displayName],
        friendImageUrl = data[FirebaseFieldName.imageUrl];

  late String friendID;
  late String friendName;
  late String friendImageUrl;
}

extension FriendEntityConvertFunctions on FriendEntity {
  FriendModel toFriendModel() {
    final model = FriendModel(
      friendID: friendID,
      friendName: friendName,
      friendImageUrl: friendImageUrl,
    );
    return model;
  }
}
