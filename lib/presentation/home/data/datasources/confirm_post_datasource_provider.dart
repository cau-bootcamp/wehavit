import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/home/data/datasources/confirm_post_datasource.dart';
import 'package:wehavit/presentation/home/data/datasources/confirm_post_remote_datasource_impl.dart';

final confirmPostDatasourceProvider = Provider<ConfirmPostDatasource>((ref) {
  return ConfirmPostRemoteDatasourceImpl();
});
