import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/resolution_repository_impl.dart';
import 'package:wehavit/data/repositories/user_model_repository_impl.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';
import 'package:wehavit/domain/repositories/user_model_fetch_repository.dart';

final getResolutionListByUserIdUsecaseProvider =
    Provider<GetResolutionListByUserIdUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return GetResolutionListByUserIdUsecase(
      resolutionRepository, userModelRepository);
});

class GetResolutionListByUserIdUsecase
    extends FutureUseCase<List<ResolutionEntity>, String> {
  GetResolutionListByUserIdUsecase(
    this._resolutionRepository,
    this._userModelRepository,
  );

  final ResolutionRepository _resolutionRepository;
  final UserModelRepository _userModelRepository;

  @override
  EitherFuture<List<ResolutionEntity>> call(String params) async {
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
