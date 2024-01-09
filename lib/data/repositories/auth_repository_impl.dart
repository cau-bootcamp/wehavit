// ignore_for_file: avoid_catches_without_on_clauses

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/auth_google_datasource.dart';
import 'package:wehavit/data/datasources/auth_wehavit_datasource.dart';
import 'package:wehavit/presentation/auth/data/entities/auth_result.dart';
import 'package:wehavit/presentation/features.dart';

class WehavitAuthRepositoryImpl implements AuthRepository {
  WehavitAuthRepositoryImpl(
    this._authDataSource,
    this._googleAuthDataSource,
  );

  final AuthWehavitDataSource _authDataSource;
  final AuthGoogleDatasource _googleAuthDataSource;

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
  EitherFuture<AuthResult> logInWithGoogle() async {
    try {
      final result = await _googleAuthDataSource.googleLogIn();
      return Right(result);
    } catch (e) {
      return const Left(Failure('something went wrong'));
    }
  }

  @override
  Future<void> logOut() async {
    return await _authDataSource.logOut();
  }

  @override
  Future<void> googleLogOut() async {
    return await _googleAuthDataSource.googleLogOut();
  }

  @override
  EitherFuture<AuthResult> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _authDataSource.registerWithEmailAndPassword(
        email,
        password,
      );

      return Right(result);
    } catch (e) {
      return const Left(Failure('something went wrong'));
    }
  }

  @override
  EitherFuture<AuthResult> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _authDataSource.logInWithEmailAndPassword(
        email,
        password,
      );

      return Right(result);
    } catch (e) {
      return const Left(Failure('something went wrong'));
    }
  }
}
