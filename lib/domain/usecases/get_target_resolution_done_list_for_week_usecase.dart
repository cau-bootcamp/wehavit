import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetTargetResolutionDoneListForWeekUsecase {
  GetTargetResolutionDoneListForWeekUsecase(
    this._resolutionRepository,
  );

  final ResolutionRepository _resolutionRepository;

  EitherFuture<List<bool>> call({required GetTargetResolutionDoneListForWeekUsecaseParams param}) {
    return _resolutionRepository.getResolutionDoneListForWeek(
      resolutionId: param.resolutionId,
      startMonday: param.startMonday,
    );
  }
}

class GetTargetResolutionDoneListForWeekUsecaseParams {
  GetTargetResolutionDoneListForWeekUsecaseParams({required this.resolutionId, required this.startMonday});

  final String resolutionId;
  final DateTime startMonday;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetTargetResolutionDoneListForWeekUsecaseParams &&
        other.resolutionId == resolutionId &&
        other.startMonday == startMonday;
  }

  @override
  int get hashCode => resolutionId.hashCode ^ startMonday.hashCode;
}
