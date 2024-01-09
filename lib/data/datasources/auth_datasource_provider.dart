import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/datasources/auth_google_datasource.dart';
import 'package:wehavit/data/datasources/auth_google_datasource_impl.dart';
import 'package:wehavit/data/datasources/auth_wehavit_datasource.dart';
import 'package:wehavit/data/datasources/auth_wehavit_datasource_impl.dart';

final wehavitAuthDatasourceProvider = Provider<AuthWehavitDataSource>((ref) {
  return AuthWehavitDataSourceImpl();
});

final googleAuthDatasourceProvider = Provider<AuthGoogleDatasource>((ref) {
  return AuthGoogleDatasourceImpl();
});
