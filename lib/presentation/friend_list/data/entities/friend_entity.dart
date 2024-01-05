import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

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
  UserDataEntity toFriendModel() {
    final model = UserDataEntity(
      friendEmail: friendEmail,
      friendName: friendName,
      friendImageUrl: friendImageUrl,
    );
    return model;
  }
}
