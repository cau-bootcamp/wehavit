import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class SearchUserDataListByHandleUsecase {
  SearchUserDataListByHandleUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<List<EitherFuture<UserDataEntity>>> call({
    required String handle,
  }) async {
    return _userModelRepository.getUserDataListByHandle(handle: handle);
  }
}
