import 'package:wehavit/common/common.dart';

abstract class AuthSocialDataSource {
  EitherFuture<String> googleLogInAndSignUp();

  Future<void> googleLogOut();

  EitherFuture<(String, String?)> appleLogInAndSignUp();

  Future<void> appleLogOut();

  EitherFuture<void> revokeSignInWithApple();
}
