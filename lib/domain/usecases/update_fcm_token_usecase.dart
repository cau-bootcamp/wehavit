// ignore: file_names
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UpdateFCMTokenUsecase {
  UpdateFCMTokenUsecase(
    this._userModelRepository,
  );

  final UserModelRepository _userModelRepository;

  EitherFuture<void> call({
    bool delete = false,
  }) async {
    return _userModelRepository.updateFCMToken(delete: delete);
  }
}
