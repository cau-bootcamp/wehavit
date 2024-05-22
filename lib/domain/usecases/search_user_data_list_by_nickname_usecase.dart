import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class SearchUserDataListByNicknameUsecase {
  SearchUserDataListByNicknameUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<List<EitherFuture<UserDataEntity>>> call({
    required String nickname,
  }) {
    return _userModelRepository.getUserDataListByNickname(nickname: nickname);
  }
}
