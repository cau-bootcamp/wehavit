import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetMyResolutionListUsecase {
  GetMyResolutionListUsecase(
    this._resolutionRepository,
    this._userModelRepository,
  );

  final ResolutionRepository _resolutionRepository;
  final UserModelRepository _userModelRepository;

  EitherFuture<List<ResolutionEntity>> call() async {
    return _userModelRepository
        .getMyUserId()
        .then(
          (result) => result.fold(
            (l) => null,
            (uid) => uid,
          ),
        )
        .then((fetchResult) {
      if (fetchResult == null) {
        return Future(
          () => left(
            const Failure('catch error on GetResolutionListByUserIdUsecase'),
          ),
        );
      }
      return _resolutionRepository.getActiveResolutionEntityList(fetchResult);
    });
  }
}
