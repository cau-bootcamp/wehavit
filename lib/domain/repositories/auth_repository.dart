import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/common/common.dart';

abstract class AuthRepository {
  EitherFuture<(String, String?)> logIn({
    required LogInType type,
    String? email,
    String? password,
  });

  EitherFuture<String> signUp({
    required LogInType type,
    String? email,
    String? password,
  });

  Future<void> logOut();
  Stream<User?> authStateChanges();

  EitherFuture<void> revokeSignInWithApple();
}
