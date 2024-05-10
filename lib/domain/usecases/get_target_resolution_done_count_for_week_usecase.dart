import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetTargetResolutionDoneCountForWeekUsecase {
  GetTargetResolutionDoneCountForWeekUsecase(
    this._resolutionRepository,
  );

  final ResolutionRepository _resolutionRepository;

  EitherFuture<int> call({
    required String resolutionId,
    required DateTime startMonday,
  }) {
    return _resolutionRepository.getResolutionDoneCountForWeek(
      resolutionId: resolutionId,
      startMonday: startMonday,
    );
  }
}
