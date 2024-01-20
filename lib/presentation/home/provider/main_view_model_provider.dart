import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/home/model/main_view_model.dart';

final mainViewModelProvider =
    StateNotifierProvider<MainViewModelProvider, MainViewModel>(
  (ref) => MainViewModelProvider(ref),
);

class MainViewModelProvider extends StateNotifier<MainViewModel> {
  MainViewModelProvider(Ref ref) : super(MainViewModel()) {
    _fetchUserDataFromIdUsecase = ref.watch(fetchUserDataFromIdUsecaseProvider);

    _sendCommentReactionToConfirmPostUsecase =
        ref.watch(sendCommentReactionToConfirmPostUsecaseProvider);
    _sendEmojiReactionToConfirmPostUsecase =
        ref.watch(sendEmojiReactionToConfirmPostUsecaseProvider);
    _sendQuickShotReactionToConfirmPostUsecase =
        ref.watch(sendQuickShotReactionToConfirmPostUsecaseProvider);

    getConfirmPostListForResolutionIdUsecase =
        ref.watch(getConfirmPostListForResolutionIdUsecaseProvider);
  }

  late final FetchUserDataFromIdUsecase _fetchUserDataFromIdUsecase;
  late final SendCommentReactionToConfirmPostUsecase
      _sendCommentReactionToConfirmPostUsecase;
  late final SendEmojiReactionToConfirmPostUsecase
      _sendEmojiReactionToConfirmPostUsecase;
  late final SendQuickShotReactionToConfirmPostUsecase
      _sendQuickShotReactionToConfirmPostUsecase;
  late final GetConfirmPostListForResolutionIdUsecase
      getConfirmPostListForResolutionIdUsecase;
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> getTodayConfirmPostModelList() async {
    // state.confirmPostModelList =
    //     await _getTodayConfirmPostListUsecase(NoParams());

    state.confirmPostModelList.fold(
      (failure) {
        state.userModelList = [];
      },
      (confirmPostEntityList) {
        state.userModelList = List<Future<UserDataEntity>>.generate(
          confirmPostEntityList.length,
          (_) => Future(() => UserDataEntity.dummyModel),
        );
        state.confirmPostList = List<Future<List<ConfirmPostEntity>>>.generate(
          confirmPostEntityList.length,
          (_) => Future(() => []),
        );

        for (int index = 0; index < confirmPostEntityList.length; index++) {
          final postEntity = confirmPostEntityList[index];
          state.userModelList[index] = getUserEntityFromId(postEntity.owner!);
          state.confirmPostList[index] = getConfirmPostListFor(
            resolutionId: postEntity.resolutionId!,
          );
        }

        state.currentCellIndex = 0;
      },
    );
  }

  Future<UserDataEntity> getUserEntityFromId(String targetUserId) async {
    final fetchResult = await _fetchUserDataFromIdUsecase(targetUserId);

    UserDataEntity resultUserEntity = fetchResult.fold(
      (failure) {
        return UserDataEntity.dummyModel;
      },
      (userDataEntity) {
        return userDataEntity;
      },
    );

    return Future(() => resultUserEntity);
  }

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

      await state.cameraController.initialize();
      state.isCameraInitialized = true;
      return Future(() => true);
    }

    return Future(() => true);
  }

  void unfocusCommentTextForm() {
    state.commentFieldFocus.unfocus();
    startGrowingLayout();
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
    unfocusCommentTextForm();

    _sendCommentReactionToConfirmPostUsecase(
      (
        entity,
        state.textEditingController.text,
      ),
    );
    state.textEditingController.clear();
  }

  void startGrowingLayout() {
    state.animationController.forward();
  }

  void startShrinkingLayout() {
    state.animationController.reverse();
  }

  Future<List<ConfirmPostEntity>> getConfirmPostListFor({
    required String resolutionId,
  }) async {
    final confirmListFetchResult =
        await getConfirmPostListForResolutionIdUsecase(resolutionId);

    return Future<List<ConfirmPostEntity>>(
      () => confirmListFetchResult.fold(
        (failure) => [],
        (modelList) => modelList,
      ),
    );
  }
}
