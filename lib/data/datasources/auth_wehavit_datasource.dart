import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/domain/entities/auth_result_entity/auth_result_entity.dart';

abstract class AuthWehavitDataSource {
  Future<AuthResult> registerWithEmailAndPassword(
    String email,
    String password,
  );

  Future<AuthResult> logInWithEmailAndPassword(String email, String password);

  Future<void> logOut();

  Stream<User?> authStateChanges();
}
