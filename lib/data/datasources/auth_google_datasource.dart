import 'package:wehavit/domain/entities/entities.dart';

abstract class AuthGoogleDatasource {
  Future<AuthResult> googleLogInAndSignUp();

  Future<void> googleLogOut();
}
