import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetMyUserDataUsecase {
  GetMyUserDataUsecase(
    this._userModelRepository,
  );

  final UserModelRepository _userModelRepository;

  EitherFuture<UserDataEntity> call() async {
    final uid = await _userModelRepository
        .getMyUserId()
        .then((result) => result.fold((failure) => null, (uid) => uid));

    if (uid == null) {
      return Future(() => const Left(Failure('unable to get my id')));
    }

    return _userModelRepository.getUserDataEntityById(uid);
  }
}
