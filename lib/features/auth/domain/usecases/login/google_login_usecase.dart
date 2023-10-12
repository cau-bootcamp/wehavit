import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/auth/auth.dart';

class GoogleLogInUseCase implements UseCase<AuthResult, NoParams> {
  GoogleLogInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, AuthResult>> call(NoParams params) async {
    return await _authRepository.logIn();
  }
}
