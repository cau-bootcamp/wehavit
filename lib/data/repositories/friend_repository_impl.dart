import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class FriendRepositoryImpl implements FriendRepository {
  FriendRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<List<UserDataEntity>> getFriendEntityList() async {
    return _wehavitDatasource.getFriendModelList();
  }

  @override
  EitherFuture<bool> registerFriend(String email) async {
    return _wehavitDatasource.registerFriend(email);
  }
}
