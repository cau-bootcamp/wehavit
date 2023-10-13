import 'package:wehavit/features/auth/auth.dart';

class LogOutUseCase {
  LogOutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() async {
    return await _repository.logOut();
  }
}
