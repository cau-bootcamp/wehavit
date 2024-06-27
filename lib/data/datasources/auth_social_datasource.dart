import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class AuthSocialDataSource {
  EitherFuture<AuthResult> googleLogInAndSignUp();

  Future<void> googleLogOut();

  EitherFuture<(AuthResult, String?)> appleLogInAndSignUp();

  Future<void> appleLogOut();

  EitherFuture<void> revokeSignInWithApple();
}
