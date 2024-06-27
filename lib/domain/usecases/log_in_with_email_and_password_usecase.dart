import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class LogInWithEmailUsecase {
  LogInWithEmailUsecase(this._authRepository);

  final AuthRepository _authRepository;

  EitherFuture<(AuthResult, String?)> call(String email, String password) {
    return _authRepository.logIn(
      type: LogInType.wehavit,
      email: email,
      password: password,
    );
  }
}
