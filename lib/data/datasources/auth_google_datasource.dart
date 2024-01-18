import 'package:wehavit/domain/entities/entities.dart';

abstract class AuthGoogleDatasource {
  Future<AuthResult> googleLogIn();

  Future<void> googleLogOut();
}
