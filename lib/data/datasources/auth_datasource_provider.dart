import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/datasources/google_auth_datasource.dart';
import 'package:wehavit/data/datasources/google_auth_datasource_impl.dart';
import 'package:wehavit/data/datasources/wehavit_auth_datasource.dart';
import 'package:wehavit/data/datasources/wehavit_auth_datasource_impl.dart';

final wehavitAuthDatasourceProvider = Provider<WehavitAuthDataSource>((ref) {
  return WehavitAuthDataSourceImpl();
});

final googleAuthDatasourceProvider = Provider<GoogleAuthDatasource>((ref) {
  return GoogleAuthDatasourceImpl();
});
