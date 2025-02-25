import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/group_entity/group_entity.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';
import 'package:wehavit/presentation/common_components/group_list_cell.dart';

class GetGroupListViewFriendCellWidgetModelUsecase {
  GetGroupListViewFriendCellWidgetModelUsecase(
    this._groupRepository,
  );

  final GroupRepository _groupRepository;
  EitherFuture<GroupListCellModel> call({
    required List<String> friendUidList,
    required List<String> sharedResolutionIdList,
  }) async {
    final (int, int)? countTuple =
        await _groupRepository.getGroupListViewFriendCellModelData(sharedResolutionIdList).then(
              (value) => value.fold(
                (failure) => null,
                (data) => data,
              ),
            );

    if (countTuple == null) {
      return Future(
        () => left(
          const Failure('fail to get group list view cell model data'),
        ),
      );
    }

    return Future(
      () => right(
        GroupListCellModel(
          sharedResolutionCount: countTuple.$1,
          sharedPostCount: countTuple.$2,
          groupEntity: GroupEntity.dummy.copyWith(groupMemberUidList: friendUidList),
        ),
      ),
    );
  }
}
