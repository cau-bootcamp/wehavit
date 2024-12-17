import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class CheckWeatherUserIsMnagerOfGroupEntityUsecase {
  CheckWeatherUserIsMnagerOfGroupEntityUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<bool> call(GroupEntity groupEntity) async {
    String? userId =
        await _userModelRepository.getMyUserId().then((value) => value.fold((failure) => null, (userId) => userId));

    if (userId == null) {
      return Future(() => left(const Failure('cannot get user id')));
    }

    if (userId == groupEntity.groupManagerUid) {
      return Future(() => right(true));
    }

    return Future(() => right(false));
  }
}
