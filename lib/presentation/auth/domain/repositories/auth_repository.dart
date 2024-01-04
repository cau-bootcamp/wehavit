import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/auth/data/entities/auth_result.dart';

abstract class AuthRepository {
  EitherFuture<AuthResult> logInWithGoogle();

  EitherFuture<AuthResult> registerWithEmailAndPassword(
    String email,
    String password,
  );

  EitherFuture<AuthResult> logInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> logOut();

  Future<void> googleLogOut();

  Stream<User?> authStateChanges();
}
