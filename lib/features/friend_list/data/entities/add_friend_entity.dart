import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/friend_list/domain/models/add_friend_model.dart';

class AddFriendEntity {
  AddFriendEntity.fromAddFriendModel(AddFriendModel model) {
    //print('model : ${model.friendID}');
    friendEmail = model.friendEmail;
  }

  late String friendEmail;
}

extension AddFriendEntityConvertFunctions on AddFriendEntity {
  Map<String, dynamic> toFirebaseDocument() {
    final Map<String, dynamic> doc = {};
    try {
      doc[FirebaseFieldName.friendEmail] = friendEmail;
      doc[FirebaseFieldName.friendState] = 0;
    } on Exception {
      //print('Error : $friendID');
    }
    return doc;
  }
}
