// ignore_for_file: avoid_catches_without_on_clauses

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    EitherFuture<AuthResult> futureResult;

    switch (type) {
      case LogInType.wehavit:
        try {
          futureResult = _authDataSource.logInWithEmailAndPassword(
            email: email,
            password: password,
          );
        } catch (e) {
          return left(Failure(AuthResult.failure.name));
        }
      case LogInType.google:
        try {
          futureResult = _googleAuthDataSource.googleLogInAndSignUp();
        } catch (e) {
          return left(Failure(AuthResult.failure.name));
        }
      default:
        return left(Failure(AuthResult.failure.name));
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);

    return futureResult;
  }

  @override
  EitherFuture<AuthResult> signUp({
    required LogInType type,
    String? email,
    String? password,
  }) async {
    EitherFuture<AuthResult> futureResult;

    switch (type) {
      case LogInType.wehavit:
        try {
          futureResult = _authDataSource.signUpWithEmailAndPassword(
            email: email,
            password: password,
          );
        } catch (e) {
          return left(Failure(AuthResult.failure.name));
        }

      case LogInType.google:
        try {
          futureResult = _googleAuthDataSource.googleLogInAndSignUp();
        } catch (e) {
          return left(Failure(AuthResult.failure.name));
        }
      default:
        return left(Failure(AuthResult.failure.name));
    }

    return futureResult;
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }
}
