import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';

class ConfirmPostEntity {
  ConfirmPostEntity.fromFirebaseDocument(Map<String, dynamic> data)
      : userImageUrl = data[FirebaseUserFieldName.email],
        userName = data[FirebaseUserFieldName.displayName],
        resolutionGoalStatement = data[FirebaseUserFieldName.imageUrl];

  late String userImageUrl;
  late String userName;
  late String resolutionGoalStatement;
  late String title;
  late String content;
  late String contentImageUrl;
  late DateTime postAt;
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
