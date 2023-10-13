import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/auth/auth.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDatasourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});
