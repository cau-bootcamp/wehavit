import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class AuthGoogleDatasource {
  EitherFuture<AuthResult> googleLogInAndSignUp();

  Future<void> googleLogOut();
}
