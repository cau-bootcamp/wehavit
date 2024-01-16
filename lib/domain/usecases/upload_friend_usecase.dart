import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/repositories/friend_repository_impl.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';

final registerFriendUsecaseProvider = Provider<RegisterFriendUsecase>((ref) {
  final friendRepository = ref.watch(friendRepositoryProvider);
  return RegisterFriendUsecase(friendRepository);
});

class RegisterFriendUsecase implements FutureUseCase<bool, String> {
  RegisterFriendUsecase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  EitherFuture<bool> call(String email) async {
    return await _friendRepository.registerFriend(email);
  }
}
