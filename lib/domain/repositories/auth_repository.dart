import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class AuthRepository {
  EitherFuture<(AuthResult, String?)> logIn({
    required LogInType type,
    String? email,
    String? password,
  });

  EitherFuture<AuthResult> signUp({
    required LogInType type,
    String? email,
    String? password,
  });

  Future<void> logOut();
  Stream<User?> authStateChanges();
}
