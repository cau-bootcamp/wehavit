import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';
import 'package:wehavit/presentation/group/model/model.dart';

class GetGroupListViewCellWidgetModelUsecase {
  GetGroupListViewCellWidgetModelUsecase(
    this._groupRepository,
  );

  final GroupRepository _groupRepository;
  EitherFuture<GroupListViewCellWidgetModel> call({
    required GroupEntity groupEntity,
  }) async {
    final (EitherFuture<int>, EitherFuture<int>)? countTuple =
        await _groupRepository.getGroupListViewCellModelData(groupEntity.groupId).then(
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
        GroupListViewCellWidgetModel(
          groupEntity: groupEntity,
          sharedResolutionCount: countTuple.$1,
          sharedPostCount: countTuple.$2,
        ),
      ),
    );
  }
}
