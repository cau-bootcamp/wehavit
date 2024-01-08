import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/datasources/wehavit_auth_datasource.dart';
import 'package:wehavit/data/datasources/wehavit_auth_datasource_impl.dart';

final authRemoteDatasourceProvider = Provider<WehavitAuthDataSource>((ref) {
  return WehavitAuthDataSourceImpl();
});
