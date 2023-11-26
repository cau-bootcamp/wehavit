import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';

class ConfirmPostEntity {
  ConfirmPostEntity.fromFirebaseDocument(
    (String, String) userData,
    Map<String, dynamic> data,
  )   : userImageUrl = userData.$1,
        userName = userData.$2,
        resolutionGoalStatement =
            data[FirebaseConfirmPostFieldName.resolutionGoalStatement],
        title = data[FirebaseConfirmPostFieldName.title],
        content = data[FirebaseConfirmPostFieldName.content],
        contentImageUrl = data[FirebaseConfirmPostFieldName.imageUrl],
        postAt = data[FirebaseConfirmPostFieldName.createdAt];

  // 초기화
  late String userImageUrl = '';
  late String userName = '';
  late String resolutionGoalStatement = '';
  late String title = '';
  late String content = '';
  late String contentImageUrl = '';
  late Timestamp postAt = Timestamp.now();
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
