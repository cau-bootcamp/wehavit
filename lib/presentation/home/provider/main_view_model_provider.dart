import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/usecases/fetch_user_data_from_id_usecase.dart';
import 'package:wehavit/domain/usecases/get_confirm_post_list_for_resolution_id.dart';
import 'package:wehavit/domain/usecases/upload_reaction_to_target_confirm_post.dart';
import 'package:wehavit/presentation/home/model/main_view_model.dart';

final mainViewModelProvider =
    StateNotifierProvider<MainViewModelProvider, MainViewModel>(
  (ref) => MainViewModelProvider(ref),
);

class MainViewModelProvider extends StateNotifier<MainViewModel> {
  MainViewModelProvider(Ref ref) : super(MainViewModel()) {
    _fetchUserDataFromIdUsecase = ref.watch(fetchUserDataFromIdUsecaseProvider);
    _sendReactionToTargetConfirmPostUsecase =
        ref.watch(uploadReactionToTargetConfirmPostUsecaseProvider);

    getConfirmPostListForResolutionIdUsecase =
        ref.watch(getConfirmPostListForResolutionIdUsecaseProvider);
  }

  late final FetchUserDataFromIdUsecase _fetchUserDataFromIdUsecase;
  late final UploadReactionToTargetConfirmPostUsecase
      _sendReactionToTargetConfirmPostUsecase;
  late final GetConfirmPostListForResolutionIdUsecase
      getConfirmPostListForResolutionIdUsecase;
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> getTodayConfirmPostModelList() async {
    // TODO: 오늘의 Confirm Post Entity List를 불러오기
    // state.confirmPostModelList =
    //     await _getTodayConfirmPostListUsecase.call(NoParams());

    state.confirmPostModelList.fold((failure) {
      state.userModelList = [];
    }, (confirmPostModelList) {
      state.userModelList = List<Future<UserDataEntity>>.generate(
        confirmPostModelList.length,
        (_) => Future(() => UserDataEntity.dummyModel),
      );
      state.confirmPostList = List<Future<List<ConfirmPostEntity>>>.generate(
        confirmPostModelList.length,
        (_) => Future(() => []),
      );

      for (int index = 0; index < confirmPostModelList.length; index++) {
        final model = confirmPostModelList[index];
        state.userModelList[index] = getUserModelFromId(model.owner!);
        state.confirmPostList[index] =
            getConfirmPostListFor(resolutionId: model.resolutionId ?? 'NO_ID');
      }

      state.currentCellIndex = 0;
    });

    return Future(() => null);
  }

  Future<UserDataEntity> getUserModelFromId(String targetUserId) async {
    final fetchResult = await _fetchUserDataFromIdUsecase.call(targetUserId);

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

  Future<void> sendReactionToTargetConfirmPost(
    ReactionEntity reactionModel,
    String confirmModleId,
  ) async {
    await _sendReactionToTargetConfirmPostUsecase
        .call((confirmModleId, reactionModel));

    return Future(() => null);
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

  Future<void> sendEmojiReaction({required String confirmModleId}) async {
    state.emojiWidgets.clear();

    if (state.sendingEmojis.any((element) => element > 0)) {
      final Map<String, int> emojiMap = {};
      state.sendingEmojis.asMap().forEach(
            (index, value) => emojiMap.addAll(
              {'t${index.toString().padLeft(2, '0')}': value},
            ),
          );

      final reactionModel = ReactionEntity(
        complimenterUid: currentUserUid,
        reactionType: ReactionType.emoji.index,
        emoji: emojiMap,
        confirmPostId: confirmModleId,
      );

      sendReactionToTargetConfirmPost(reactionModel, confirmModleId);

      state.sendingEmojis = List<int>.generate(15, (index) => 0);
    }
  }

  Future<void> sendImageReaction({
    required String imageFilePath,
    required String confirmModleId,
  }) async {
    final reactionModel = ReactionEntity(
      complimenterUid: FirebaseAuth.instance.currentUser!.uid,
      reactionType: ReactionType.quickShot.index,
      instantPhotoUrl: imageFilePath,
      confirmPostId: confirmModleId,
    );

    sendReactionToTargetConfirmPost(reactionModel, confirmModleId);
  }

  Future<void> sendTextReaction({required String confirmModleId}) async {
    unfocusCommentTextForm();

    final reactionModel = ReactionEntity(
      complimenterUid: FirebaseAuth.instance.currentUser!.uid,
      reactionType: ReactionType.comment.index,
      comment: state.textEditingController.text,
      confirmPostId: confirmModleId,
    );

    sendReactionToTargetConfirmPost(
      reactionModel,
      confirmModleId,
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
