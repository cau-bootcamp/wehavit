import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class ApplyForJoiningGroupUsecase extends FutureUseCase<void, String> {
  ApplyForJoiningGroupUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  @override
  EitherFuture<void> call(String params) {
    return _groupRepository.applyForJoiningGroup(groupId: params);
  }
}
