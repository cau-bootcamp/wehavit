import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class WithdrawalFromGroupUsecase extends FutureUseCase<void, String> {
  WithdrawalFromGroupUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  @override
  EitherFuture<void> call(String params) {
    return _groupRepository.withdrawalFromGroup(
      groupId: params,
    );
  }
}
