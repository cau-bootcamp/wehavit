import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/auth/data/entities/auth_result.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> logIn();

  Future<void> logOut();

  Stream<User?> authStateChanges();
}
