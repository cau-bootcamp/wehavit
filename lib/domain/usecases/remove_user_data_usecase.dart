import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class RemoveCurrentUserDataUsecase {
  RemoveCurrentUserDataUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<void> call() {
    return _userModelRepository.removeCurrentUserData();
  }
}
