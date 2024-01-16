import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/models/auth_result_model.dart';
import 'package:wehavit/domain/repositories/auth_repository.dart';

class EmailAndPasswordLogInUseCase {
  EmailAndPasswordLogInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  EitherFuture<AuthResult> call(String email, String password) {
    return _authRepository.logInWithEmailAndPassword(email, password);
  }
}
