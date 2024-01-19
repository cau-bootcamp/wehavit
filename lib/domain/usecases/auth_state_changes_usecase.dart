import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class AuthStateChangesUseCase {
  AuthStateChangesUseCase(this._repository);

  final AuthRepository _repository;

  Stream<User?> call() {
    return _repository.authStateChanges();
  }
}
