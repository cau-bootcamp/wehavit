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

final swipeViewModelProvider =
    StateNotifierProvider<SwipeViewModelProvider, SwipeViewModel>(
  (ref) => SwipeViewModelProvider(ref),
);

@freezed
class SwipeViewModel {
  // Carousel UI Variables
  CarouselController carouselController = CarouselController();
  int currentCellNumber = 0;
  Either<Failure, List<ConfirmPostModel>> confirmPostModelList = right([]);

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
    state = state
      ..confirmPostModelList =
          await _getTodayConfirmPostListUsecase.call(NoParams());
    return Future(() => null);
  }

  late final FetchUserDataFromIdUsecase _fetchUserDataFromIdUsecase;

  Future<UserModel> getUserModelFromId(String targetUserId) async {
    final fetchResult = await _fetchUserDataFromIdUsecase.call(targetUserId);
    fetchResult.fold((l) {
      return Future(
        () => UserModel(
          displayName: 'good',
          email: 'email',
          imageUrl:
              'https://media.istockphoto.com/id/961829842/ko/사진/나쁜-고양이-은행-강도.jpg?s=1024x1024&w=is&k=20&c=7mc4cum-tQaOlV0R9xGD0LINLMmho2OpV9FYZigIgfI=',
        ),
      );
    }, (r) {
      return Future(
        () => UserModel(
          displayName: 'good',
          email: 'email',
          imageUrl:
              'https://media.istockphoto.com/id/961829842/ko/사진/나쁜-고양이-은행-강도.jpg?s=1024x1024&w=is&k=20&c=7mc4cum-tQaOlV0R9xGD0LINLMmho2OpV9FYZigIgfI=',
        ),
      );
    });

    throw UnimplementedError();
  }

  late final SendReactionToTargetConfirmPostUsecase
      _sendReactionToTargetConfirmPostUsecase;

  Future<void> sendReactionToTargetConfirmPost(
    String targetConfirmPostId,
    ReactionModel reactionModel,
  ) async {
    _sendReactionToTargetConfirmPostUsecase
        .call((targetConfirmPostId, reactionModel));
  }
}
