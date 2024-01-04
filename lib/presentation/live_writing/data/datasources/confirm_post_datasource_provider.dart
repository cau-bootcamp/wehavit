import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/live_writing/data/datasources/datasources.dart';

final confirmPostDatasourceProvider = Provider<ConfirmPostDatasource>((ref) {
  return ConfirmPostRemoteDatasourceImpl();
});
