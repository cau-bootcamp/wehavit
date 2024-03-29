import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/dependency/data/repository_dependency.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';
import 'package:wehavit/presentation/presentation.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final usecaseGoogleLogIn = ref.watch(googleLogInUseCaseProvider);
  final emailAndPasswordRegister =
      ref.watch(emailAndPasswordRegisterUseCaseProvider);
  final emailAndPasswordLogIn = ref.watch(emailAndPasswordLogInUseCaseProvider);
  final googleLogOut = ref.watch(googleLogOutUseCaseProvider);
  final usecaseLogOut = ref.watch(logOutUseCaseProvider);

  return AuthNotifier(
    usecaseGoogleLogIn,
    emailAndPasswordRegister,
    emailAndPasswordLogIn,
    googleLogOut,
    usecaseLogOut,
  );
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final authStateChanges = AuthStateChangesUseCase(repository);
  return authStateChanges();
});

final balloonManagerProvider =
    StateNotifierProvider<BalloonManager, Map<Key, BalloonWidget>>(
  (ref) {
    return BalloonManager();
  },
);

final addFriendProvider =
    StateNotifierProvider.autoDispose<AddFriendNotifier, String>((ref) {
  return AddFriendNotifier(ref);
});

final friendListProvider = StateNotifierProvider<FriendListProvider,
    Either<Failure, List<UserDataEntity>>>((ref) {
  return FriendListProvider(ref);
});

final confirmPostListProvider = StateNotifierProvider<ConfirmPostListProvider,
    Either<Failure, List<ConfirmPostEntity>>>((ref) {
  return ConfirmPostListProvider(ref);
});

final addResolutionProvider =
    StateNotifierProvider.autoDispose<AddResolutionNotifier, ResolutionEntity>(
        (ref) {
  return AddResolutionNotifier(ref);
});

final myPageResolutionListProvider = StateNotifierProvider<
    MyPageResolutionListProvider,
    Either<
        Failure,
        (
          List<ResolutionEntity>,
          List<Future<List<ConfirmPostEntity>>>
        )>>((ref) {
  return MyPageResolutionListProvider(ref);
});

final reactionAnimationWidgetManagerProvider =
    StateNotifierProvider<ReactionAnimationWidgetManager, void>((ref) {
  return ReactionAnimationWidgetManager(ref);
});

// Group View
final groupViewModelProvider =
    StateNotifierProvider.autoDispose<GroupViewModelProvider, GroupViewModel>(
        (ref) {
  final getGroupListUsecase = ref.watch(getGroupListUseCaseProvider);
  final getGroupListViewCellWidgetModelUsecase =
      ref.watch(getGroupListViewCellWidgetModelUsecaseProvider);
  return GroupViewModelProvider(
    getGroupListUsecase,
    getGroupListViewCellWidgetModelUsecase,
  );
});

final createGroupViewModelProvider = StateNotifierProvider.autoDispose<
    CreateGroupViewModelProvider, CreateGroupViewModel>((ref) {
  final createGroupUsecase = ref.watch(createGroupUsecaseProvider);
  return CreateGroupViewModelProvider(createGroupUsecase);
});

final resolutionListViewModelProvider = StateNotifierProvider.autoDispose<
    ResolutionListViewModelProvider, ResolutionListViewModel>((ref) {
  final getMyResolutionListUsecase =
      ref.watch(getMyResolutionListUsecaseProvider);
  final getTargetResolutionDoneCountForWeekUsecase =
      ref.watch(getTargetResolutionDoneCountForWeekUsecaseProvider);
  final uploadConfirmPostUsecase = ref.watch(uploadConfirmPostUseCaseProvider);
  return ResolutionListViewModelProvider(
    getMyResolutionListUsecase,
    getTargetResolutionDoneCountForWeekUsecase,
    uploadConfirmPostUsecase,
  );
});

final writingConfirmPostViewModelProvider = StateNotifierProvider.autoDispose<
    WritingConfirmPostViewModelProvider, WritingConfirmPostViewModel>((ref) {
  final uploadConfirmPostUsecase = ref.watch(uploadConfirmPostUseCaseProvider);
  return WritingConfirmPostViewModelProvider(uploadConfirmPostUsecase);
});

final groupPostViewModelProvider = StateNotifierProvider.autoDispose<
    GroupPostViewModelProvider, GroupPostViewModel>((ref) {
  final sendEmojiReactionToConfirmPostUsecase =
      ref.watch(sendEmojiReactionToConfirmPostUsecaseProvider);
  final sendQuickShotReactionToConfirmPostUsecase =
      ref.watch(sendQuickShotReactionToConfirmPostUsecaseProvider);
  final sendCommentReactionToConfirmPostUsecase =
      ref.watch(sendCommentReactionToConfirmPostUsecaseProvider);
  return GroupPostViewModelProvider(
    sendEmojiReactionToConfirmPostUsecase,
    sendQuickShotReactionToConfirmPostUsecase,
    sendCommentReactionToConfirmPostUsecase,
  );
});
