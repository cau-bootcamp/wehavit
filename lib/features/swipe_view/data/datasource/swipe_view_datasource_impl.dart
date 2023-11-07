import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/data/datasource/swipe_view_datasource.dart';

class SwipeViewDatasourceImpl implements SwipeViewDatasource {
  @override
  EitherFuture<List<ConfirmPostModel>> fetchLiveWrittenConfirmPostList() async {
    try {
      final fetchResult =
          await FirebaseFirestore.instance.collection("confirm_posts").get();

      final modelList = fetchResult.docs
          .map((json) => ConfirmPostModel.fromJson(json.data()))
          .toList();

      return Future(() => right(modelList));
    } on Exception {
      return Future(
        () => left(
          const Failure("catch error on fetchLiveWrittenConfirmPostList"),
        ),
      );
    }
  }

  @override
  EitherFuture<List<ConfirmPostModel>> fetchTodayConfirmPostList() async {
    try {
      final fetchResult =
          await FirebaseFirestore.instance.collection("confirm_posts").get();

      final modelList = fetchResult.docs
          .where((doc) => doc.data().containsKey('resolutionGoalStatement'))
          .map((json) {
        return ConfirmPostModel(
          resolutionGoalStatement: json['resolutionGoalStatement'] as String?,
          resolutionId: const DocumentReferenceJsonConverter()
              .fromJson(json['resolutionId']),
          title: json['title'] as String?,
          content: json['content'] as String?,
          imageUrl: json['imageUrl'] as String?,
          recentStrike: json['recentStrike'] as int?,
          createdAt: json['createdAt'] == null
              ? null
              : DateTime.parse(
                  (json['createdAt'] as Timestamp).toDate().toString(),
                ),
          updatedAt: json['updatedAt'] == null
              ? null
              : DateTime.parse(
                  (json['createdAt'] as Timestamp).toDate().toString(),
                ),
          roles: (json['roles'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ),
          attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ),
        );
      }).toList();
      print("CAPTURE");

      print(modelList.first);
      final temp = modelList.toList();

      return Future(() => right(temp));
    } on Exception {
      return Future(
        () => left(
          const Failure("catch error on fetchTodayConfirmPostList"),
        ),
      );
    }
  }
}
