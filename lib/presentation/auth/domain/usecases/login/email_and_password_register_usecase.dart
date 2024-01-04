import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/auth/auth.dart';

class EmailAndPasswordRegisterUseCase {
  EmailAndPasswordRegisterUseCase(this._authRepository);

  final AuthRepository _authRepository;

  EitherFuture<AuthResult> call(String email, String password) {
    return _authRepository.registerWithEmailAndPassword(email, password);
  }
}
