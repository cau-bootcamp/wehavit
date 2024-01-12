import 'package:wehavit/data/models/auth_result_model.dart';

abstract class AuthGoogleDatasource {
  Future<AuthResult> googleLogIn();

  Future<void> googleLogOut();
}
