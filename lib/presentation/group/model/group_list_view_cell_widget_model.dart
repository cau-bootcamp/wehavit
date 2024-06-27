import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

class GroupListViewCellWidgetModel {
  GroupListViewCellWidgetModel({
    required this.groupEntity,
    required this.sharedPostCount,
    required this.sharedResolutionCount,
  });

  GroupEntity groupEntity;
  final EitherFuture<int> sharedResolutionCount;
  final EitherFuture<int> sharedPostCount;

  static final dummyModel = GroupListViewCellWidgetModel(
    groupEntity: GroupEntity(
      groupName: '갱생프로젝트',
      groupManagerUid: 'groupManagerUid',
      groupMemberUidList: [],
      groupColor: 5,
      groupId: '12345',
      groupCreatedAt: DateTime.now().subtract(const Duration(days: 3)),
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
