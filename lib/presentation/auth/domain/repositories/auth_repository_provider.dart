import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/datasources/auth_datasource_provider.dart';
import 'package:wehavit/data/repositories/auth_repository_impl.dart';
import 'package:wehavit/presentation/auth/auth.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final wehavitAuthDataSource = ref.watch(wehavitAuthDatasourceProvider);
  final googleAuthDataSource = ref.watch(googleAuthDatasourceProvider);
  return WehavitAuthRepositoryImpl(
    wehavitAuthDataSource,
    googleAuthDataSource,
  );
});
