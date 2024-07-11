import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';

class GroupPostViewModelProvider extends StateNotifier<GroupPostViewModel> {
  GroupPostViewModelProvider(
    this._getGroupConfirmPostListByDateUsecase,
    this._sendEmojiReactionToConfirmPostUsecase,
    this._sendQuickShotReactionToConfirmPostUsecase,
    this._sendCommentReactionToConfirmPostUsecase,
    this.getAppliedUserListForGroupEntityUsecase,
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

  Future<void> loadConfirmPostEntityListFor({
    required DateTime dateTime,
  }) async {
    final selectedDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    state.confirmPostList[selectedDate] =
        _getGroupConfirmPostListByDateUsecase(state.groupId, selectedDate);
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
        state.textEditingController.text,
      ),
    );
    state.textEditingController.clear();
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
}
