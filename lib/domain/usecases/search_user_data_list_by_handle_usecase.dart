import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class SearchUserByHandleUsecase {
  SearchUserByHandleUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<List<String>> call({
    required String handle,
  }) async {
    return _userModelRepository.getUidListByHandle(handle: handle);
  }
}
