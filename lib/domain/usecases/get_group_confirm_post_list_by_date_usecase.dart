import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetConfirmPostListByDateUsecase {
  GetConfirmPostListByDateUsecase(this._confirmPostRepository);

  final ConfirmPostRepository _confirmPostRepository;

  EitherFuture<List<ConfirmPostEntity>> call(
    List<String> resolutionList,
    DateTime selectedDate,
  ) async {
    return _confirmPostRepository.getConfirmPostEntityListByDate(
      resolutionList: resolutionList,
      selectedDate: selectedDate,
    );
  }
}
