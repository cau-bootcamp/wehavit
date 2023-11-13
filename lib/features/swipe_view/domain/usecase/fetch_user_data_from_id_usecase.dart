import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/swipe_view/domain/repository/user_model_fetch_repository.dart';

class FetchUserDataFromIdUsecase extends UseCase<UserModel, String> {
  FetchUserDataFromIdUsecase(this._userModelFetchRepository);

  final UserModelFetchRepository _userModelFetchRepository;
  @override
  EitherFuture<UserModel> call(params) {
    return _userModelFetchRepository.fetchUserModelFromId(params);
  }
}
