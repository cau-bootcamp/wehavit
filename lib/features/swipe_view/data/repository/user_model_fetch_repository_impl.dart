import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/swipe_view/data/datasource/user_model_fetch_datasource.dart';
import 'package:wehavit/features/swipe_view/data/datasource/user_model_fetch_datasource_provider.dart';
import 'package:wehavit/features/swipe_view/domain/repository/user_model_fetch_repository.dart';

class UserModelFetchRepositoryImpl implements UserModelFetchRepository {
  UserModelFetchRepositoryImpl(Ref ref) {
    _userModelFetchDatasource = ref.watch(userModelFetchDatasourceProvider);
  }

  late final UserModelFetchDatasource _userModelFetchDatasource;

  @override
  EitherFuture<UserModel> fetchUserModelFromId(String targetUserId) {
    return _userModelFetchDatasource.fetchUserModelFromId(targetUserId);
  }
}
