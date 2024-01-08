import 'package:wehavit/presentation/auth/data/entities/auth_result.dart';

abstract class GoogleAuthDatasource {
  Future<AuthResult> googleLogIn();

  Future<void> googleLogOut();
}
