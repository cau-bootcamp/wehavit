import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/domain.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';

class FriendPostViewModelProvider extends StateNotifier<FriendPostViewModel> {
  //
  FriendPostViewModelProvider(
    this._getFriendConfirmPostListByDateUsecase,
    this._sendEmojiReactionToConfirmPostUsecase,
    this._sendQuickShotReactionToConfirmPostUsecase,
    this._sendCommentReactionToConfirmPostUsecase,
    this._sendNotificationToTargetUserUsecase,
    this._getUserDataFromIdUsecase,
  ) : super(FriendPostViewModel());

  final GetFriendConfirmPostListByDateUsecase _getFriendConfirmPostListByDateUsecase;

  final SendEmojiReactionToConfirmPostUsecase _sendEmojiReactionToConfirmPostUsecase;
  final SendQuickShotReactionToConfirmPostUsecase _sendQuickShotReactionToConfirmPostUsecase;
  final SendCommentReactionToConfirmPostUsecase _sendCommentReactionToConfirmPostUsecase;
  final SendNotificationToTargetUserUsecase _sendNotificationToTargetUserUsecase;
  final GetUserDataFromIdUsecase _getUserDataFromIdUsecase;

  Future<void> loadConfirmPostEntityListFor({
    required DateTime dateTime,
  }) async {
    final selectedDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    state.confirmPostList[selectedDate] = _getFriendConfirmPostListByDateUsecase(
      state.sharedResolutionIdList,
      selectedDate,
    );
  }

  // Reactions
  Future<void> sendEmojiReaction({required ConfirmPostEntity entity}) async {
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
          if (!isSendingReactionSuccess) {
            return;
          }

          sendReactionNotification(
            myUserEntity: UserDataEntity.dummyModel,
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
  }) async {
    _sendQuickShotReactionToConfirmPostUsecase((entity, imageFilePath));
  }

  Future<void> sendTextReaction({required ConfirmPostEntity entity}) async {
    _sendCommentReactionToConfirmPostUsecase(
      (
        entity,
        state.commentEditingController.text,
      ),
    );
    state.commentEditingController.clear();
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

  Future<void> sendReactionNotification({
    required UserDataEntity myUserEntity,
    required ConfirmPostEntity postEntity,
  }) async {
    final targetUserEntity = await _getUserDataFromIdUsecase
        .call(postEntity.owner)
        .then((result) => result.fold((failure) => null, (entity) => entity));

    if (targetUserEntity == null) {
      return;
    }

    _sendNotificationToTargetUserUsecase(
      myUserEntity: myUserEntity,
      targetUserEntity: targetUserEntity,
    );
  }
}
