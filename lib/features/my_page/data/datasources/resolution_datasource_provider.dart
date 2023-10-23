import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_remote_datasource_impl.dart';

final resolutionDatasourceProvider = Provider<ResolutionDatasource>((ref) {
  return ResolutionRemoteDatasourceImpl();
});
