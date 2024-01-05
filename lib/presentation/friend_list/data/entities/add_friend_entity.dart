import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/domain/entities/add_friend_entity/add_friend_model.dart';

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
      doc[FirebaseFriendFieldName.friendEmail] = friendEmail;
      doc[FirebaseFriendFieldName.friendState] = 0;
    } on Exception {
      //print('Error : $friendID');
    }
    return doc;
  }
}
