import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/auth/auth.dart';
import 'package:wehavit/presentation/auth/data/entities/auth_result.dart';

class EmailAndPasswordLogInUseCase {
  EmailAndPasswordLogInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  EitherFuture<AuthResult> call(String email, String password) {
    return _authRepository.logInWithEmailAndPassword(email, password);
  }
}
