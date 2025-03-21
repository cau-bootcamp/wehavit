import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UserModelRepositoryImpl implements UserModelRepository {
  UserModelRepositoryImpl(
    this._wehavitDatasource,
    this._authDataSource,
  );

  final WehavitDatasource _wehavitDatasource;
  final AuthDataSource _authDataSource;

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
  EitherFuture<List<String>> getAppliedUserIdList({
    required String forUser,
  }) {
    return _wehavitDatasource.getAppliedUserIdList(forUser: forUser);
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

  @override
  EitherFuture<List<String>> getUidListByHandle({
    required String handle,
  }) async {
    return _wehavitDatasource.getUidListByHandle(handle: handle);
  }

  @override
  EitherFuture<void> registerUserData({
    required String uid,
    required String name,
    required File userImageFile,
    required String aboutMe,
    required String handle,
  }) {
    return _wehavitDatasource.registerUserData(
      uid: uid,
      name: name,
      userImageFile: userImageFile,
      aboutMe: aboutMe,
      handle: handle,
    );
  }

  @override
  EitherFuture<void> removeCurrentUserData() {
    return _authDataSource.removeCurrentUserData();
  }

  @override
  EitherFuture<void> updateFCMToken({required bool delete}) {
    return _wehavitDatasource.updateFCMToken(delete: delete);
  }

  @override
  EitherFuture<String> getUserFCMMessageToken({required String uid}) {
    return _wehavitDatasource.getUserFCMMessageToken(uid: uid);
  }

  @override
  EitherFuture<List<QuickshotPresetItemEntity>> getQuickshotPresets() {
    return _wehavitDatasource.getQuickshotPresets();
  }

  @override
  EitherFuture<void> uploadQuickshotPreset(
    String quickshotImageUrl,
  ) {
    return _wehavitDatasource.uploadQuickshotPreset(
      quickshotImageUrl: quickshotImageUrl,
    );
  }

  @override
  EitherFuture<void> removeQuickshotPreset(
    QuickshotPresetItemEntity quickshotPresetItemEntity,
  ) {
    return _wehavitDatasource.removeQuickshotPreset(
      entity: quickshotPresetItemEntity,
    );
  }
}
