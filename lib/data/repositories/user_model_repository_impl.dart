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
    return _wehavitDatasource.fetchUserDataEntityByUserId(targetUserId);
  }

  @override
  EitherFuture<String> getMyUserId() {
    return Future(() => right(_wehavitDatasource.getMyUserId()));
  }

  @override
  Future<void> incrementUserDataCounter({
    required UserIncrementalDataType type,
  }) {
    return _wehavitDatasource.incrementUserDataCounter(type: type);
  }
}
