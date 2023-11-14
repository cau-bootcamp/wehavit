// Login Usecase is Actually 1:1 with the Repository

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/auth/auth.dart';

final loginWithEmailAndPasswordProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.watch(authRemoteDatasourceProvider),
  ),
);
