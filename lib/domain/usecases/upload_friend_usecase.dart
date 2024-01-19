import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class RegisterFriendUsecase implements FutureUseCase<bool, String> {
  RegisterFriendUsecase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  EitherFuture<bool> call(String email) async {
    return await _friendRepository.registerFriend(email);
  }
}
