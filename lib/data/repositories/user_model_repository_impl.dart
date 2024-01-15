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
    final userModelRequest =
        await _wehavitDatasource.fetchUserModelFromId(targetUserId);

    final Either<Failure, UserDataEntity> result = userModelRequest.fold(
      (failure) => left(Failure(failure.message)),
      (userModel) => right(userModel.toUserDataEntity()),
    );

    return Future(() => result);
  }
}
