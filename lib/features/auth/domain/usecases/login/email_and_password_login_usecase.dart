import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/auth/auth.dart';

class EmailAndPasswordLogInUseCase {
  EmailAndPasswordLogInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  EitherFuture<AuthResult> call(String email, String password) {
    return _authRepository.logInWithEmailAndPassword(email, password);
  }
}
