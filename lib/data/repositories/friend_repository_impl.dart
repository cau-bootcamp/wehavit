import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/wehavit_datasource.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';

final friendRepositoryProvider = Provider<FriendRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return FriendRepositoryImpl(wehavitDatasource);
});

class FriendRepositoryImpl implements FriendRepository {
  FriendRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<List<UserDataEntity>> getFriendEntityList() async {
    try {
      final getResult = await _wehavitDatasource.getFriendModelList();

      return getResult.fold(
        (failure) => left(failure),
        (modelList) {
          final entityList =
              modelList.map((model) => model.toUserDataEntity()).toList();
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
