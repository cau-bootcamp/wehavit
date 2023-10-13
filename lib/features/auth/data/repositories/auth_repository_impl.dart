// ignore_for_file: avoid_catches_without_on_clauses

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/features.dart';

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
  Future<Either<Failure, AuthResult>> logIn() async {
    try {
      final result = await _authRemoteDataSource.googleLogIn();
      return Right(result);
    } catch (e) {
      return const Left(Failure('something went wrong'));
    }
  }

  @override
  Future<void> logOut() async {
    return await _authRemoteDataSource.googleLogOut();
  }
}
