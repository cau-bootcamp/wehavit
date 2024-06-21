import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/utils/utils.dart';

class GroupListViewFriendCellWidgetModel {
  GroupListViewFriendCellWidgetModel({
    required this.friendCount,
    required this.sharedPostCount,
    required this.sharedResolutionCount,
  });

  final EitherFuture<int> friendCount;
  final EitherFuture<int> sharedResolutionCount;
  final EitherFuture<int> sharedPostCount;

  // List<String> friendUidList = [];
  // List<String> sharedResolutionIdList = [];
  Map<String, List<String>> friendIdResolutionMap = {};

  static final dummyModel = GroupListViewFriendCellWidgetModel(
    friendCount: Future.delayed(
      const Duration(seconds: 2),
      () {
        return right(13);
      },
    ),
    sharedResolutionCount: Future.delayed(
      const Duration(seconds: 2),
      () {
        return right(13);
      },
    ),
    sharedPostCount: Future.delayed(const Duration(seconds: 3), () {
      return right(13);
    }),
  );
}
