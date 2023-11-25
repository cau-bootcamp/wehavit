import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';

class ConfirmPostEntity {
  ConfirmPostEntity.fromFirebaseDocument(Map<String, dynamic> data)
      : //userImageUrl = data[FirebaseFriendFieldName.friendImageUrl],
        //userName = data[FirebaseFriendFieldName.friendName],
        resolutionGoalStatement =
            data[FirebaseConfirmPostFieldName.resolutionGoalStatement],
        title = data[FirebaseConfirmPostFieldName.title],
        //postAt = data[FirebaseConfirmPostFieldName.updatedAt];
        //contentImageUrl = data[FirebaseConfirmPostFieldName.imageUrl];
        content = data[FirebaseConfirmPostFieldName.content];

  late String userImageUrl = 'userImageUrl';
  late String userName = 'userName';
  late String resolutionGoalStatement = 'resolutionGoalStatement';
  late String title = 'title';
  late String content = 'content';
  late String contentImageUrl = 'imageUrl';
  late DateTime postAt = DateTime(2023, 11, 25, 14);
}

extension ConfirmPostEntityConvertFunctions on ConfirmPostEntity {
  ConfirmPostModel toConfirmPostModel() {
    final model = ConfirmPostModel(
      userImageUrl: userImageUrl,
      userName: userName,
      resolutionGoalStatement: resolutionGoalStatement,
      title: title,
      content: content,
      contentImageUrl: contentImageUrl,
      postAt: postAt,
    );
    return model;
  }
}
