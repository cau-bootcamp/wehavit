import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/friend_list/domain/models/add_friend_model.dart';

class AddFriendEntity {
  AddFriendEntity.fromAddFriendModel(AddFriendModel model) {
    friendID = model.friendID;
  }

  late String friendID;
}

extension AddFriendEntityConvertFunctions on AddFriendEntity {
  Map<String, dynamic> toFirebaseDocument() {
    final Map<String, dynamic> doc = {};
    doc[FirebaseFieldName.friendDocRef] = friendID;
    return doc;
  }

  AddFriendModel toFriendModel() {
    final model = AddFriendModel(
      friendID: friendID,
    );
    return model;
  }
}