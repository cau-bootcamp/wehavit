import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/presentation/auth/auth.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResult> googleLogIn();

  Future<AuthResult> registerWithEmailAndPassword(
    String email,
    String password,
  );

  Future<AuthResult> logInWithEmailAndPassword(String email, String password);

  Future<void> logOut();

  Future<void> googleLogOut();

  Stream<User?> authStateChanges();
}
