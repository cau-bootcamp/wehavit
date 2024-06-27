import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class RevokeAppleSignInUsecase {
  RevokeAppleSignInUsecase(this._authRepository);

  final AuthRepository _authRepository;

  EitherFuture<void> call() {
    return _authRepository.revokeSignInWithApple();
  }
}
