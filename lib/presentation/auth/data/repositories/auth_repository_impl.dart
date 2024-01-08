// ignore_for_file: avoid_catches_without_on_clauses

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/features.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Stream<User?> authStateChanges() {
    try {
      final result = _authRemoteDataSource.authStateChanges();
      return result;
    } catch (e) {
      throw const Failure('there is no user');
    }
  }

  @override
  EitherFuture<AuthResult> logInWithGoogle() async {
    try {
      final result = await _authRemoteDataSource.googleLogIn();
      return Right(result);
    } catch (e) {
      return const Left(Failure('something went wrong'));
    }
  }

  @override
  Future<void> logOut() async {
    return await _authRemoteDataSource.logOut();
  }

  @override
  Future<void> googleLogOut() async {
    return await _authRemoteDataSource.googleLogOut();
  }

  @override
  EitherFuture<AuthResult> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _authRemoteDataSource.registerWithEmailAndPassword(
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
      final result = await _authRemoteDataSource.logInWithEmailAndPassword(
        email,
        password,
      );

      return Right(result);
    } catch (e) {
      return const Left(Failure('something went wrong'));
    }
  }
}
