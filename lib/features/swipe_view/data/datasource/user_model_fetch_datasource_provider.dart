import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/data/datasource/user_model_fetch_datasource.dart';
import 'package:wehavit/features/swipe_view/data/datasource/user_model_fetch_datasource_impl.dart';

final userModelFetchDatasourceProvider =
    Provider<UserModelFetchDatasource>((ref) {
  return UserModelFetchDatasourceImpl();
});
