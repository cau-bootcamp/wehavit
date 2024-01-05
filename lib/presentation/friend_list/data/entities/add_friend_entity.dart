import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/domain/entities/friend_entity/friend_model.dart';

class AddFriendEntity {
  AddFriendEntity.fromAddFriendModel(FriendModel model) {
    //print('model : ${model.friendID}');
    friendEmail = model.friendEmail ?? 'no_email';
  }

  late String friendEmail;
}

extension AddFriendEntityConvertFunctions on AddFriendEntity {
  Map<String, dynamic> toFirebaseDocument() {
    final Map<String, dynamic> doc = {};
    try {
      doc[FirebaseFriendFieldName.friendEmail] = friendEmail;
      doc[FirebaseFriendFieldName.friendState] = 0;
    } on Exception {
      //print('Error : $friendID');
    }
    return doc;
  }
}
