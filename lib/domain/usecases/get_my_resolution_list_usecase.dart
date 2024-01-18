import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/resolution_repository_impl.dart';
import 'package:wehavit/data/repositories/user_model_repository_impl.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final getMyResolutionListByUserIdUsecaseProvider =
    Provider<GetMyResolutionListByUserIdUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return GetMyResolutionListByUserIdUsecase(
    resolutionRepository,
    userModelRepository,
  );
});

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
