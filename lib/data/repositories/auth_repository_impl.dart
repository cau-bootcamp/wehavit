// ignore_for_file: avoid_catches_without_on_clauses

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._authDataSource,
    this._googleAuthDataSource,
  );

  final AuthDataSource _authDataSource;
  final AuthGoogleDatasource _googleAuthDataSource;

  @override
  EitherFuture<AuthResult> logIn({
    required LogInType type,
    String? email,
    String? password,
  }) async {
    switch (type) {
      case LogInType.wehavit:
        try {
          final result = await _authDataSource.logInWithEmailAndPassword(
            email: email,
            password: password,
          );

          return result;
        } catch (e) {
          return const Left(Failure('something went wrong'));
        }
      case LogInType.google:
        try {
          final result = await _googleAuthDataSource.googleLogInAndSignUp();
          return Right(result);
        } catch (e) {
          return const Left(Failure('something went wrong'));
        }
      default:
    }

    return left(Failure(AuthResult.failure.name));
  }

  @override
  EitherFuture<AuthResult> signUp({
    required LogInType type,
    String? email,
    String? password,
  }) async {
    switch (type) {
      case LogInType.wehavit:
        try {
          final result = await _authDataSource.signUpWithEmailAndPassword(
            email: email,
            password: password,
          );

          return result;
        } catch (e) {
          return const Left(Failure('something went wrong'));
        }

      case LogInType.google:
        try {
          final result = await _googleAuthDataSource.googleLogInAndSignUp();
          return Right(result);
        } catch (e) {
          return const Left(Failure('something went wrong'));
        }
      default:
    }

    return left(Failure(AuthResult.failure.name));
  }

  @override
  Stream<User?> authStateChanges() {
    try {
      final result = _authDataSource.authStateChanges();
      return result;
    } catch (e) {
      throw const Failure('there is no user');
    }
  }

  @override
  Future<void> logOut() async {
    await _authDataSource.logOut();
    await _googleAuthDataSource.googleLogOut();
  }
}
