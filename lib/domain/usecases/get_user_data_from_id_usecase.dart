import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetUserDataFromIdUsecase extends FutureUseCase<UserDataEntity, String> {
  GetUserDataFromIdUsecase(this._userDataEntityFetchRepository);

  final UserModelRepository _userDataEntityFetchRepository;
  @override
  EitherFuture<UserDataEntity> call(String params) {
    return _userDataEntityFetchRepository.getUserDataEntityById(params);
  }
}
