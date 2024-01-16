import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/models/auth_result_model.dart';
import 'package:wehavit/domain/repositories/auth_repository.dart';

class GoogleLogInUseCase implements FutureUseCase<AuthResult, NoParams> {
  GoogleLogInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  EitherFuture<AuthResult> call(NoParams params) async {
    return await _authRepository.logInWithGoogle();
  }
}
