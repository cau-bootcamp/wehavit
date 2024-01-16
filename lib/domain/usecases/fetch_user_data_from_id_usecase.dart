import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/repositories/user_model_repository_impl.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/repositories/user_model_fetch_repository.dart';

final fetchUserDataFromIdUsecaseProvider =
    Provider<FetchUserDataFromIdUsecase>((ref) {
  final repository = ref.watch(userModelRepositoryProvider);
  return FetchUserDataFromIdUsecase(repository);
});

class FetchUserDataFromIdUsecase extends FutureUseCase<UserDataEntity, String> {
  FetchUserDataFromIdUsecase(this._userDataEntityFetchRepository);

  final UserModelRepository _userDataEntityFetchRepository;
  @override
  EitherFuture<UserDataEntity> call(String params) {
    return _userDataEntityFetchRepository.fetchUserDataEntityFromId(params);
  }
}
