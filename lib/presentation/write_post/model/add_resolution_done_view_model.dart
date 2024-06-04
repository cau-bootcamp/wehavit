import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/group/model/model.dart';

class AddResolutionDoneViewModel {
  List<EitherFuture<UserDataEntity>>? friendList = [
    Future(() => right(UserDataEntity.dummyModel)),
    Future(() => right(UserDataEntity.dummyModel)),
    Future(() => right(UserDataEntity.dummyModel)),
  ];

  List<bool>? selectedFriendList = [
    false,
    false,
    false,
  ];

  List<GroupListViewCellWidgetModel>? groupModelList = [
    GroupListViewCellWidgetModel.dummyModel,
  ];

  List<EitherFuture<GroupEntity>>? groupList = [
    Future(
      () => right(
        GroupEntity(
          groupName: 'dummy',
          groupManagerUid: 'dummy',
          groupMemberUidList: ['dummy'],
          groupCreatedAt: DateTime.now(),
          groupColor: 0,
          groupId: 'dummy',
        ),
      ),
    ),
  ];

  List<bool>? selectedGroupList = [
    false,
  ];
}
