import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/presentation/auth/data/entities/auth_result.dart';

abstract class WehavitAuthDataSource {
  Future<AuthResult> registerWithEmailAndPassword(
    String email,
    String password,
  );

  Future<AuthResult> logInWithEmailAndPassword(String email, String password);

  Future<void> logOut();

  Stream<User?> authStateChanges();
}
