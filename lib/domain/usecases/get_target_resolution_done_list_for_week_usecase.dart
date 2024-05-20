import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetTargetResolutionDoneListForWeekUsecase {
  GetTargetResolutionDoneListForWeekUsecase(
    this._resolutionRepository,
  );

  final ResolutionRepository _resolutionRepository;

  EitherFuture<List<bool>> call({
    required String? resolutionId,
    required DateTime startMonday,
  }) {
    if (resolutionId == null) {
      return Future(() => left(const Failure('resolution id is null')));
    }
    return _resolutionRepository.getResolutionDoneListForWeek(
      resolutionId: resolutionId,
      startMonday: startMonday,
    );
  }
}
