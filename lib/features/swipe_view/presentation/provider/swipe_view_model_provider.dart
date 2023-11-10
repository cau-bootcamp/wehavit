import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/swipe_view_usecase.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/swipe_view.dart';
import 'package:collection/collection.dart';

final swipeViewModelProvider =
    StateNotifierProvider<SwipeViewModelProvider, SwipeViewModel>(
  (ref) => SwipeViewModelProvider(ref),
);

@freezed
class SwipeViewModel {
  // Carousel UI Variables
  CarouselController carouselController = CarouselController();
  int _currentCellIndex = 0;
  int get currentCellIndex => _currentCellIndex;
  set currentCellIndex(int newIndex) {
    _currentCellIndex = newIndex;
    _currentCellConfirmPostModel =
        confirmPostModelList.foldRight(null, (acc, b) => b[_currentCellIndex]);
  }

  Either<Failure, List<ConfirmPostModel>> confirmPostModelList = right([]);
  List<Future<UserModel>> userModelList = [];

  ConfirmPostModel? _currentCellConfirmPostModel;
  ConfirmPostModel? get currentCellConfirmModel => _currentCellConfirmPostModel;

  // Camera Reaction UI Variables
  late CameraController cameraController;

  // Emoji Reaction UI Variables
  Map<Key, ShootEmojiWidget> emojiWidgets = {};
  int countSend = 0;
  List<int> sendingEmojis = List<int>.generate(15, (index) => 0);
}

class SwipeViewModelProvider extends StateNotifier<SwipeViewModel> {
  SwipeViewModelProvider(Ref ref) : super(SwipeViewModel()) {
    _getTodayConfirmPostListUsecase =
        ref.watch(getTodayConfirmPostListUsecaseProvider);
    _fetchUserDataFromIdUsecase = ref.watch(fetchUserDataFromIdUsecaseProvider);
    _sendReactionToTargetConfirmPostUsecase =
        ref.watch(sendReactionToTargetConfirmPostUsecaseProvider);
  }

  late final GetTodayConfirmPostListUsecase _getTodayConfirmPostListUsecase;

  Future<void> getTodayConfirmPostModelList() async {
    state.confirmPostModelList =
        await _getTodayConfirmPostListUsecase.call(NoParams());

    state.confirmPostModelList.fold((failure) {
      state.userModelList = [];
    }, (confirmPostModelList) {
      state.userModelList = List<Future<UserModel>>.generate(
        confirmPostModelList.length,
        (index) => Future(() => UserModel.dummyModel),
      );

      for (int index = 0; index < confirmPostModelList.length; index++) {
        final model = confirmPostModelList[index];
        state.userModelList[index] = getUserModelFromId(
          model.roles!.keys.firstWhere(
            (element) => model.roles![element] == 'owner',
          ),
        );
      }

      state.currentCellIndex = 0;
    });

    return Future(() => null);
  }

  late final FetchUserDataFromIdUsecase _fetchUserDataFromIdUsecase;

  Future<UserModel> getUserModelFromId(String targetUserId) async {
    final fetchResult = await _fetchUserDataFromIdUsecase.call(targetUserId);

    UserModel resultUserModel = fetchResult.fold(
      (failure) {
        return UserModel.dummyModel;
      },
      (userModel) {
        return userModel;
      },
    );

    return Future(() => resultUserModel);
  }

  late final SendReactionToTargetConfirmPostUsecase
      _sendReactionToTargetConfirmPostUsecase;

  Future<void> sendReactionToTargetConfirmPost(
    ReactionModel reactionModel,
  ) async {
    if (state.currentCellConfirmModel == null) {
      return Future(() => null);
    }

    await _sendReactionToTargetConfirmPostUsecase
        .call((state.currentCellConfirmModel!.id!, reactionModel));

    return Future(() => null);
  }
}
