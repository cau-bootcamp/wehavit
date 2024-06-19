import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class LogInWithAppleUsecase {
  LogInWithAppleUsecase(this._authRepository);

  final AuthRepository _authRepository;

  EitherFuture<AuthResult> call() async {
    return _authRepository.logIn(type: LogInType.apple);
  }
}
