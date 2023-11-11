import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/friend_list/domain/models/add_friend_model.dart';

class AddFriendEntity {
  AddFriendEntity.fromAddFriendModel(AddFriendModel model) {
    //print('model : ${model.friendID}');
    friendID = model.friendID;
  }

  late String friendID;
}

extension AddFriendEntityConvertFunctions on AddFriendEntity {
  Map<String, dynamic> toFirebaseDocument() {
    final Map<String, dynamic> doc = {};
    if (!friendID.contains('users/')) {
      friendID = 'users/$friendID';
    }
    try {
      doc[FirebaseFieldName.friendDocRef] = friendID;
    } on Exception {
      //print('Error : $friendID');
    }
    return doc;
  }
}
