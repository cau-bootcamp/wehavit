import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/wehavit_datasource.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/repositories/user_model_fetch_repository.dart';

final userModelRepositoryProvider = Provider<UserModelRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return UserModelRepositoryImpl(wehavitDatasource);
});

class UserModelRepositoryImpl implements UserModelRepository {
  UserModelRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<UserDataEntity> fetchUserDataEntityFromId(
    String targetUserId,
  ) async {
    final userEntityRequest =
        await _wehavitDatasource.fetchUserDataEntityByUserId(targetUserId);

    final Either<Failure, UserDataEntity> result = userEntityRequest.fold(
      (failure) => left(Failure(failure.message)),
      (entity) => right(entity),
    );

    return Future(() => result);
  }

  @override
  EitherFuture<String> getMyUserId() {
    return _wehavitDatasource.getMyUserId();
  }
}
