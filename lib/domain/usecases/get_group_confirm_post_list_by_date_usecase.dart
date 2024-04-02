import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetGroupConfirmPostListByDateUsecase {
  GetGroupConfirmPostListByDateUsecase(this._confirmPostRepository);

  final ConfirmPostRepository _confirmPostRepository;

  EitherFuture<List<ConfirmPostEntity>> call(
    String groupId,
    DateTime selectedDate,
  ) async {
    return _confirmPostRepository.getGroupConfirmPostEntityListByDate(
      groupId: groupId,
      selectedDate: selectedDate,
    );
  }
}
