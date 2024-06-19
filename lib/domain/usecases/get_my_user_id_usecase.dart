import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetMyUserIdUsecase {
  GetMyUserIdUsecase(
    this._userModelRepository,
  );

  final UserModelRepository _userModelRepository;

  EitherFuture<String> call() async {
    return _userModelRepository.getMyUserId();
  }
}
