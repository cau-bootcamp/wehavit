import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/features/auth/auth.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResult> googleLogIn();

  Future<void> googleLogOut();

  Stream<User?> authStateChanges();
}
