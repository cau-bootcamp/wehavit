import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/add_friend_entity/add_friend_model.dart';
import 'package:wehavit/domain/entities/friend_entity/friend_model.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';
import 'package:wehavit/presentation/friend_list/data/datasources/friend_datasource.dart';
import 'package:wehavit/presentation/friend_list/data/datasources/friend_datasource_provider.dart';
import 'package:wehavit/presentation/friend_list/data/entities/add_friend_entity.dart';
import 'package:wehavit/presentation/friend_list/data/entities/friend_entity.dart';

class FriendRepositoryImpl implements FriendRepository {
  FriendRepositoryImpl(Ref ref) {
    _friendDatasource = ref.watch(friendDatasourceProvider);
  }

  late final FriendDatasource _friendDatasource;

  @override
  EitherFuture<List<FriendModel>> getFriendModelList() async {
    try {
      final getResult = await _friendDatasource.getFriendEntityList();

      return getResult.fold((failure) => left(failure), (entityList) {
        final modelList =
            entityList.map((entity) => entity.toFriendModel()).toList();

        return Future(() => right(modelList));
      });
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<bool> uploadFriendModel(
    AddFriendModel model,
  ) async {
    final entity = AddFriendEntity.fromAddFriendModel(model);
    return _friendDatasource.uploadAddFriendEntity(entity);
  }
}
