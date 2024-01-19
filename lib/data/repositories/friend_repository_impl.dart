import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class FriendRepositoryImpl implements FriendRepository {
  FriendRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<List<UserDataEntity>> getFriendEntityList() async {
    try {
      final getResult = await _wehavitDatasource.getFriendModelList();

      return getResult.fold(
        (failure) => left(failure),
        (entityList) {
          return Future(() => right(entityList));
        },
      );
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<bool> registerFriend(String email) async {
    return _wehavitDatasource.registerFriend(email);
  }
}
