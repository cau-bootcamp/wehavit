import 'package:wehavit/domain/repositories/repositories.dart';

class LogOutUsecase {
  LogOutUsecase(this._repository);

  final AuthRepository _repository;

  Future<void> call() async {
    return await _repository.logOut();
  }
}

class GoogleLogOutUseCase {
  GoogleLogOutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() async {
    return await _repository.logOut();
  }
}
