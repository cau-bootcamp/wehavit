import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';

class ConfirmPostModel {
  ConfirmPostModel({
    required this.userImageUrl,
    required this.userName,
    required this.resolutionGoalStatement,
    required this.title,
    required this.content,
    required this.contentImageUrl,
    required this.postAt,
  });

  String userImageUrl;
  String userName;
  String resolutionGoalStatement;
  String title;
  String content;
  String contentImageUrl;
  DateTime postAt;

  ConfirmPostModel copyWith({
    String? userImageUrl,
    String? userName,
    String? resolutionGoalStatement,
    String? title,
    String? content,
    String? contentImageUrl,
    DateTime? postAt,
  }) {
    return ConfirmPostModel(
      userImageUrl: userImageUrl ?? this.userImageUrl,
      userName: userName ?? this.userName,
      resolutionGoalStatement:
          resolutionGoalStatement ?? this.resolutionGoalStatement,
      title: title ?? this.title,
      content: content ?? this.content,
      contentImageUrl: contentImageUrl ?? this.contentImageUrl,
      postAt: postAt ?? this.postAt,
    );
  }
}
