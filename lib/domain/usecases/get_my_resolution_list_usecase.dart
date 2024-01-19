import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetMyResolutionListByUserIdUsecase
    extends FutureUseCase<List<ResolutionEntity>, NoParams> {
  GetMyResolutionListByUserIdUsecase(
    this._resolutionRepository,
    this._userModelRepository,
  );

  final ResolutionRepository _resolutionRepository;
  final UserModelRepository _userModelRepository;

  @override
  EitherFuture<List<ResolutionEntity>> call(NoParams params) async {
    final fetchResult = (await _userModelRepository.getMyUserId()).fold(
      (l) => '',
      (uid) => uid,
    );

    if (fetchResult.isNotEmpty) {
      return _resolutionRepository.getActiveResolutionEntityList(fetchResult);
    } else {
      return Future(
        () => left(
          const Failure('catch error on GetResolutionListByUserIdUsecase'),
        ),
      );
    }
  }
}
