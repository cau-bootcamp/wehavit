import 'package:wehavit/domain/repositories/repositories.dart';

class LogOutUsecase {
  LogOutUsecase(
    this._authRepository,
    this._userModelRepository,
  );

  final AuthRepository _authRepository;
  final UserModelRepository _userModelRepository;

  Future<void> call() async {
    await _authRepository.logOut();
    await _userModelRepository.updateFCMToken(delete: true);
    return Future(() => null);
  }
}

class GoogleLogOutUseCase {
  GoogleLogOutUseCase(
    this._repository,
    this._userModelRepository,
  );

  final AuthRepository _repository;
  final UserModelRepository _userModelRepository;

  Future<void> call() async {
    await _repository.logOut();
    await _userModelRepository.updateFCMToken(delete: true);
    return Future(() => null);
  }
}
