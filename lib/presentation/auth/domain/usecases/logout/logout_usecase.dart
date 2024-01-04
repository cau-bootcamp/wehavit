import 'package:wehavit/presentation/auth/auth.dart';

class LogOutUseCase {
  LogOutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() async {
    return await _repository.logOut();
  }
}

class GoogleLogOutUseCase {
  GoogleLogOutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() async {
    return await _repository.googleLogOut();
  }
}
