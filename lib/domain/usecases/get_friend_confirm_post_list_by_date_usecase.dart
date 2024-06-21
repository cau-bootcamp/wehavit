import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetFriendConfirmPostListByDateUsecase {
  GetFriendConfirmPostListByDateUsecase(this._confirmPostRepository);

  final ConfirmPostRepository _confirmPostRepository;

  EitherFuture<List<ConfirmPostEntity>> call(
    List<String> targetResolutionList,
    DateTime selectedDate,
  ) async {
    return _confirmPostRepository.getFriendConfirmPostEntityListByDate(
      targetResolutionList: targetResolutionList,
      selectedDate: selectedDate,
    );
  }
}
