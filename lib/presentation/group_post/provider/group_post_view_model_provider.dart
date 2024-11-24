import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wehavit/domain/domain.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';

class GroupPostViewModelProvider extends StateNotifier<GroupPostViewModel> {
  GroupPostViewModelProvider(
    this._getGroupConfirmPostListByDateUsecase,
    this._sendEmojiReactionToConfirmPostUsecase,
    this._sendQuickShotReactionToConfirmPostUsecase,
    this._sendCommentReactionToConfirmPostUsecase,
    this.getAppliedUserListForGroupEntityUsecase,
    this._sendNotificationToTargetUserUsecase,
    this._getUserDataFromIdUsecase,
    this._uploadQuickshotPresetUsecase,
    this._getQuickshotPresetsUsecase,
    this._removeQuickshotPresetUsecase,
  ) : super(GroupPostViewModel());

  final GetGroupConfirmPostListByDateUsecase
      _getGroupConfirmPostListByDateUsecase;
  final SendEmojiReactionToConfirmPostUsecase
      _sendEmojiReactionToConfirmPostUsecase;
  final SendQuickShotReactionToConfirmPostUsecase
      _sendQuickShotReactionToConfirmPostUsecase;
  final SendCommentReactionToConfirmPostUsecase
      _sendCommentReactionToConfirmPostUsecase;
  final GetAppliedUserListForGroupEntityUsecase
      getAppliedUserListForGroupEntityUsecase;
  final SendNotificationToTargetUserUsecase
      _sendNotificationToTargetUserUsecase;
  final GetUserDataFromIdUsecase _getUserDataFromIdUsecase;
  final UploadQuickshotPresetUsecase _uploadQuickshotPresetUsecase;
  final GetQuickshotPresetsUsecase _getQuickshotPresetsUsecase;
  final RemoveQuickshotPresetUsecase _removeQuickshotPresetUsecase;

  Future<void> loadConfirmPostEntityListFor({
    required DateTime dateTime,
  }) async {
    final selectedDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    state.confirmPostList[selectedDate] =
        _getGroupConfirmPostListByDateUsecase(state.groupId, selectedDate);
  }

  // Reactions
  Future<void> sendEmojiReaction({
    required ConfirmPostEntity entity,
    required UserDataEntity? myUserEntity,
  }) async {
    state.emojiWidgets.clear();

    if (state.sendingEmojis.any((element) => element > 0)) {
      _sendEmojiReactionToConfirmPostUsecase(
        (
          entity,
          state.sendingEmojis,
        ),
      )
          .then(
        (result) => result.fold(
          (failure) => false,
          (success) => success,
        ),
      )
          .then(
        (isSendingReactionSuccess) {
          if (!isSendingReactionSuccess || myUserEntity == null) {
            return;
          }

          sendReactionNotification(
            myUserEntity: myUserEntity,
            postEntity: entity,
          );
        },
      );

      state.sendingEmojis = List<int>.generate(15, (index) => 0);
    }
  }

  Future<void> sendImageReaction({
    required String imageFilePath,
    required ConfirmPostEntity entity,
    required UserDataEntity? myUserEntity,
  }) async {
    _sendQuickShotReactionToConfirmPostUsecase((entity, imageFilePath))
        .then(
      (result) => result.fold(
        (failure) => false,
        (success) => success,
      ),
    )
        .then(
      (isSendingReactionSuccess) {
        if (!isSendingReactionSuccess || myUserEntity == null) {
          return;
        }

        sendReactionNotification(
          myUserEntity: myUserEntity,
          postEntity: entity,
        );
      },
    );
  }

  Future<void> sendPresetImageReaction({
    required QuickshotPresetItemEntity presetEntity,
    required ConfirmPostEntity entity,
    required UserDataEntity? myUserEntity,
  }) async {
    Dio dio = Dio();
    final tempDir = (await getTemporaryDirectory()).path;

    final tempDirPath = '$tempDir/preset_image';
    final tempFileName = presetEntity.id;

    if (!(await Directory(tempDirPath).exists())) {
      await Directory(tempDirPath).create(recursive: true);
    }
    final filePath = '$tempDirPath/$tempFileName';
    final file = File('$tempDirPath/$tempFileName');
    if (!(await file.exists())) {
      final response = await dio.download(presetEntity.url, filePath);

      if (response.statusCode != 200) {
        return;
      }
    }

    _sendQuickShotReactionToConfirmPostUsecase((entity, filePath))
        .then(
      (result) => result.fold(
        (failure) => false,
        (success) => success,
      ),
    )
        .then(
      (isSendingReactionSuccess) {
        if (!isSendingReactionSuccess || myUserEntity == null) {
          return;
        }

        sendReactionNotification(
          myUserEntity: myUserEntity,
          postEntity: entity,
        );
      },
    );
  }

  Future<void> sendTextReaction({
    required ConfirmPostEntity entity,
    required UserDataEntity? myUserEntity,
  }) async {
    _sendCommentReactionToConfirmPostUsecase(
      (
        entity,
        state.commentEditingController.text,
      ),
    )
        .then(
      (result) => result.fold(
        (failure) => false,
        (success) => success,
      ),
    )
        .then(
      (isSendingReactionSuccess) {
        if (!isSendingReactionSuccess || myUserEntity == null) {
          return;
        }

        sendReactionNotification(
          myUserEntity: myUserEntity,
          postEntity: entity,
        );
      },
    );
    state.commentEditingController.clear();
  }

  Future<void> uploadQuickshotPreset({
    required String imageFilePath,
  }) async {
    await _uploadQuickshotPresetUsecase(localFileUrl: imageFilePath).then(
      (result) => result.fold(
        (failure) => false,
        (success) => success,
      ),
    );
  }

  Future<void> getQuickshotPresets() async {
    await _getQuickshotPresetsUsecase().then(
      (result) => result.fold(
        (failure) {
          state.quickshotPresets = [];
        },
        (success) {
          state.quickshotPresets = success;
        },
      ),
    );
  }

  void setFocusingModeTo(bool enabled) {
    final newState = (state..isFocusingMode = enabled);
    state = newState;
  }

  Future<void> changeSelectedDate({required DateTime to}) async {
    state.selectedDate = to;
  }

  void resetSendingEmojis() {
    state.sendingEmojis = List<int>.generate(15, (index) => 0);
  }

  Future<void> loadConfirmPostsForWeek({
    required DateTime mondayOfTargetWeek,
  }) async {
    for (int i = 0; i < 7; i++) {
      await loadConfirmPostEntityListFor(
        dateTime: mondayOfTargetWeek.add(Duration(days: i)),
      );
    }
    return Future(() => null);
  }

  Future<void> loadAppliedUserCount({required GroupEntity entity}) async {
    state.appliedUserCountForManager =
        await getAppliedUserListForGroupEntityUsecase.call(entity).then(
              (result) =>
                  result.fold((failure) => 0, (uidList) => uidList.length),
            );
  }

  Future<void> sendReactionNotification({
    required UserDataEntity myUserEntity,
    required ConfirmPostEntity postEntity,
  }) async {
    if (postEntity.owner == null) {
      return;
    }

    final targetUserEntity = await _getUserDataFromIdUsecase
        .call(postEntity.owner!)
        .then((result) => result.fold((failure) => null, (entity) => entity));

    if (targetUserEntity == null) {
      return;
    }

    _sendNotificationToTargetUserUsecase(
      myUserEntity: myUserEntity,
      targetUserEntity: targetUserEntity,
    );
  }

  Future<void> removeQuickshotPresetEntity({
    required QuickshotPresetItemEntity entity,
  }) async {
    _removeQuickshotPresetUsecase(quickshotEntity: entity);
    return;
  }
}
