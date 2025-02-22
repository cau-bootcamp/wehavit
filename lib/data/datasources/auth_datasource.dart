import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

///
abstract class AuthDataSource {
  EitherFuture<String> signUpWithEmailAndPassword({
    String? email,
    String? password,
  });

  EitherFuture<String> logInWithEmailAndPassword({
    String? email,
    String? password,
  });

  Future<void> logOut();

  Stream<User?> authStateChanges();

  EitherFuture<void> removeCurrentUserData();
}
