import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

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
