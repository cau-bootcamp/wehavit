import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

class AddFriendEntity {
  AddFriendEntity.fromAddFriendModel(UserDataEntity model) {
    //print('model : ${model.friendID}');
    friendEmail = model.userEmail ?? 'no_email';
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
