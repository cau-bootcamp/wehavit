import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class SignUpWithEmailAndPasswordUsecase {
  SignUpWithEmailAndPasswordUsecase(this._authRepository);

  final AuthRepository _authRepository;

  EitherFuture<String> call(String email, String password) {
    return _authRepository.signUp(
      type: LogInType.wehavit,
      email: email,
      password: password,
    );
  }
}
