import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetConfirmPostOfDatetimeFromTargetResolutionUsecase {
  GetConfirmPostOfDatetimeFromTargetResolutionUsecase(
    this._confirmPostRepository,
  );

  final ConfirmPostRepository _confirmPostRepository;

  EitherFuture<List<ConfirmPostEntity>> call({
    required String resolutionId,
    required DateTime targetDateTime,
  }) {
    return _confirmPostRepository.getConfirmPostEntityByDate(
      targetResolutionId: resolutionId,
      selectedDate: targetDateTime,
    );
  }
}
