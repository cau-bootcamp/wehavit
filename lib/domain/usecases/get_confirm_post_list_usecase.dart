import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetConfirmPostListUsecase
    implements FutureUseCase<List<ConfirmPostEntity>?, DateTime> {
  GetConfirmPostListUsecase(this._confirmPostRepository);

  final ConfirmPostRepository _confirmPostRepository;

  @override
  EitherFuture<List<ConfirmPostEntity>> call(
    DateTime selectedDate,
  ) async {
    return _confirmPostRepository.getConfirmPostEntityListByDate(
      selectedDate: selectedDate,
    );
  }
}
