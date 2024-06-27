import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';
import 'package:wehavit/presentation/group/model/model.dart';

class GetGroupListViewFriendCellWidgetModelUsecase {
  GetGroupListViewFriendCellWidgetModelUsecase(
    this._groupRepository,
  );

  final GroupRepository _groupRepository;
  EitherFuture<GroupListViewFriendCellWidgetModel> call({
    required List<String> userIdList,
    required List<String> sharedResolutionIdList,
  }) async {
    final (EitherFuture<int>, EitherFuture<int>)? countTuple =
        await _groupRepository
            .getGroupListViewFriendCellModelData(sharedResolutionIdList)
            .then(
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
        GroupListViewFriendCellWidgetModel(
          friendCount: Future(() => right(userIdList.length)),
          sharedResolutionCount: countTuple.$1,
          sharedPostCount: countTuple.$2,
        ),
      ),
    );
  }
}
