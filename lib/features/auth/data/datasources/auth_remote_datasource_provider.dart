import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/auth/data/datasources/datasources.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl();
});
