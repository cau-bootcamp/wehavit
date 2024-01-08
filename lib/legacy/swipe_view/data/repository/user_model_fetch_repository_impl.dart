import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/repositories/user_model_fetch_repository.dart';
import 'package:wehavit/legacy/swipe_view/data/datasource/user_model_fetch_datasource.dart';
import 'package:wehavit/legacy/swipe_view/data/datasource/user_model_fetch_datasource_provider.dart';

class UserModelFetchRepositoryImpl implements UserModelFetchRepository {
  UserModelFetchRepositoryImpl(Ref ref) {
    _userDataEntityFetchDatasource =
        ref.watch(userModelFetchDatasourceProvider);
  }

  late final UserModelFetchDatasource _userDataEntityFetchDatasource;

  @override
  EitherFuture<UserDataEntity> fetchUserModelFromId(String targetUserId) {
    return _userDataEntityFetchDatasource
        .fetchUserDataEntityFromId(targetUserId);
  }
}
