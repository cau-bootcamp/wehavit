import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class LogInWithGoogleUsecase {
  LogInWithGoogleUsecase(this._authRepository);

  final AuthRepository _authRepository;

  EitherFuture<(String, String?)> call() async {
    return _authRepository.logIn(type: LogInType.google);
  }
}
