import 'package:wehavit/presentation/auth/data/entities/auth_result.dart';

abstract class AuthGoogleDatasource {
  Future<AuthResult> googleLogIn();

  Future<void> googleLogOut();
}
