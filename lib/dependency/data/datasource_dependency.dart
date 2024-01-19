import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/datasources/datasources.dart';

final wehavitDatasourceProvider = Provider<WehavitDatasource>((ref) {
  return FirebaseDatasourceImpl();
});
