import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';

class GroupPostViewModelProvider extends StateNotifier<GroupPostViewModel> {
  GroupPostViewModelProvider(
    this._sendEmojiReactionToConfirmPostUsecase,
    this._sendQuickShotReactionToConfirmPostUsecase,
    this._sendCommentReactionToConfirmPostUsecase,
  ) : super(GroupPostViewModel());

  final SendEmojiReactionToConfirmPostUsecase
      _sendEmojiReactionToConfirmPostUsecase;
  final SendQuickShotReactionToConfirmPostUsecase
      _sendQuickShotReactionToConfirmPostUsecase;
  final SendCommentReactionToConfirmPostUsecase
      _sendCommentReactionToConfirmPostUsecase;

  // Reactions
  Future<bool> initializeCamera() async {
    CameraDescription? description = await availableCameras().then(
      (cameras) {
        if (cameras.isEmpty) {
          return null;
        }

        return cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
        );
      },
      onError: (onError) {
        return Future(() => false);
      },
    );

    if (!state.isCameraInitialized && description != null) {
      state.cameraController =
          CameraController(description, ResolutionPreset.medium);

      await state.cameraController!.initialize();
      state.isCameraInitialized = true;

      return Future(() => true);
    }

    return Future(() => false);
  }

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
}
