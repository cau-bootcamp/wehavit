import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UserModelRepositoryImpl implements UserModelRepository {
  UserModelRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<UserDataEntity> getUserDataEntityById(
    String targetUserId,
  ) async {
    return _wehavitDatasource.fetchUserDataEntityByUserId(targetUserId);
  }

  @override
  EitherFuture<String> getMyUserId() {
    return Future(() => right(_wehavitDatasource.getMyUserId()));
  }

  @override
  EitherFuture<void> incrementUserDataCounter({
    required UserIncrementalDataType type,
  }) {
    return _wehavitDatasource.incrementUserDataCounter(type: type);
  }

  @override
  EitherFuture<void> updateAmoutMe({required String newAboutMe}) {
    return _wehavitDatasource.updateAboutMe(newAboutMe: newAboutMe);
  }

  @override
  EitherFuture<void> applyForFriend({required String of}) {
    return _wehavitDatasource.applyForFriend(of: of);
  }

  @override
  EitherFuture<List<EitherFuture<UserDataEntity>>> getAppliedUserList({
    required String forUser,
  }) {
    return _wehavitDatasource.getAppliedUserList(forUser: forUser);
  }

  @override
  EitherFuture<void> handleFriendJoinRequest({
    required String targetUid,
    required bool isAccept,
  }) {
    return _wehavitDatasource.handleFriendJoinRequest(
      targetUid: targetUid,
      isAccept: isAccept,
    );
  }

  @override
  EitherFuture<void> removeFriend({required String targetUid}) {
    return _wehavitDatasource.removeFriend(targetUid: targetUid);
  }

  @override
  EitherFuture<List<EitherFuture<UserDataEntity>>> getUserDataListByNickname({
    required String nickname,
  }) async {
    return _wehavitDatasource.getUserDataListByNickname(nickname: nickname);
  }
}
