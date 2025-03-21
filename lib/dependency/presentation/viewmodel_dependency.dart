import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/data/repository_dependency.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/presentation.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final usecaseGoogleLogIn = ref.watch(logInWithGoogleUsecaseProvider);
  final emailAndPasswordRegister = ref.watch(emailAndPasswordRegisterUseCaseProvider);
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

final balloonManagerProvider = StateNotifierProvider<BalloonManager, Map<Key, BalloonWidget>>(
  (ref) {
    return BalloonManager();
  },
);

final addFriendProvider = StateNotifierProvider.autoDispose<AddFriendNotifier, String>((ref) {
  return AddFriendNotifier(ref);
});

final friendListViewModelProvider = StateNotifierProvider<FriendListViewModelProvider, FriendListViewModel>((ref) {
  final AcceptApplyingForFriendUsecase acceptApplyingForFriendUsecase =
      ref.read(acceptApplyingForFriendUsecaseProvider);
  final RejectApplyingForFriendUsecase rejectApplyingForFriendUsecase =
      ref.read(rejectApplyingForFriendUsecaseProvider);
  final RemoveFriendUsecase removeFriendUsecase = ref.read(removeFriendUsecaseProvider);
  final ApplyForUserFriendUsecase applyForUserFriendUsecase = ref.read(applyForUserFriendUsecaseProvider);
  return FriendListViewModelProvider(
    ref,
    acceptApplyingForFriendUsecase,
    rejectApplyingForFriendUsecase,
    removeFriendUsecase,
    applyForUserFriendUsecase,
  );
});

final addResolutionProvider = StateNotifierProvider.autoDispose<AddResolutionNotifier, ResolutionEntity>((ref) {
  return AddResolutionNotifier(ref);
});

final myPageViewModelProvider = StateNotifierProvider<MyPageViewModelProvider, MyPageViewModel>((ref) {
  final getMyResolutionListUsecase = ref.watch(getMyResolutionListUsecaseProvider);
  final getMyUserDataUsecase = ref.watch(getMyUserDataUsecaseProvider);
  final revokeAppleSignInUsecase = ref.watch(revokeAppleSignInUsecaseProvider);
  final setResolutionDeactiveUsecase = ref.watch(setResolutionDeactiveUsecaseProvider);
  return MyPageViewModelProvider(
    getMyResolutionListUsecase,
    getMyUserDataUsecase,
    revokeAppleSignInUsecase,
    setResolutionDeactiveUsecase,
  );
});

final reactionAnimationWidgetManagerProvider = StateNotifierProvider<ReactionAnimationWidgetManager, void>((ref) {
  return ReactionAnimationWidgetManager(ref);
});

// Group View
// final groupViewModelProvider = StateNotifierProvider<GroupViewModelProvider, GroupViewModel>((ref) {
//   final getGroupListUsecase = ref.watch(getGroupListUseCaseProvider);
//   final getGroupListViewCellWidgetModelUsecase = ref.watch(getGroupListViewCellWidgetModelUsecaseProvider);
//   final getGroupListViewFriendCellWidgetModelUsecase = ref.watch(getGroupListViewFriendCellWidgetModelUsecaseProvider);
//   final getSharedResolutionIdListFromFriendUidUsecase =
//       ref.watch(getSharedResolutionIdListFromFriendUidUsecaseProvider);
//   return GroupViewModelProvider(
//     getGroupListUsecase,
//     getGroupListViewCellWidgetModelUsecase,
//     getGroupListViewFriendCellWidgetModelUsecase,
//     getSharedResolutionIdListFromFriendUidUsecase,
//   );
// });

final createGroupViewModelProvider =
    StateNotifierProvider.autoDispose<CreateGroupViewModelProvider, CreateGroupViewModel>((ref) {
  final createGroupUsecase = ref.watch(createGroupUsecaseProvider);
  return CreateGroupViewModelProvider(createGroupUsecase);
});

final resolutionListViewModelProvider =
    StateNotifierProvider<ResolutionListViewModelProvider, ResolutionListViewModel>((ref) {
  final getMyResolutionListUsecase = ref.watch(getMyResolutionListUsecaseProvider);
  final getTargetResolutionDoneCountForWeekUsecase = ref.watch(getTargetResolutionDoneListForWeekUsecaseProvider);
  final uploadConfirmPostUsecase = ref.watch(uploadConfirmPostUseCaseProvider);
  return ResolutionListViewModelProvider(
    ref,
    getMyResolutionListUsecase,
    getTargetResolutionDoneCountForWeekUsecase,
    uploadConfirmPostUsecase,
  );
});

// 구조 개편을 위한 시도 중
// final writingConfirmPostViewModelProvider =
//     StateNotifierProvider.autoDispose<WritingConfirmPostViewModelProvider, WritingConfirmPostViewModel>((ref) {
//   final uploadConfirmPostUsecase = ref.watch(uploadConfirmPostUseCaseProvider);
//   final sendNotificationToSharedUsersUsecase = ref.watch(sendNotificationToSharedUsersUsecaseProvider);
//   return WritingConfirmPostViewModelProvider(
//     ref,
//     uploadConfirmPostUsecase,
//     sendNotificationToSharedUsersUsecase,
//   );
// });

final groupPostViewModelProvider =
    StateNotifierProvider.autoDispose<GroupPostViewModelProvider, GroupPostViewModel>((ref) {
  final sendEmojiReactionToConfirmPostUsecase = ref.watch(sendEmojiReactionToConfirmPostUsecaseProvider);
  final sendQuickShotReactionToConfirmPostUsecase = ref.watch(sendQuickShotReactionToConfirmPostUsecaseProvider);
  final sendCommentReactionToConfirmPostUsecase = ref.watch(sendCommentReactionToConfirmPostUsecaseProvider);
  final getAppliedUserListForGroupEntityUsecase = ref.watch(getAppliedUserListForGroupEntityUsecaseProvider);
  final sendNotificationToTargetUserUsecase = ref.watch(sendNotificationToTargetUserUsecaseProvider);
  final getUserDataFromIdUsecase = ref.watch(getUserDataFromIdUsecaseProvider);
  final uploadQuickshotPresetUsecase = ref.watch(uploadQuickshotPresetUsecaseProvider);
  final getQuickshotPresetsUsecase = ref.watch(getQuickshotPresetsUsecaseProvider);
  final removeQuickshotPresetUsecase = ref.watch(removeQuickshotPresetUsecaseProvider);

  return GroupPostViewModelProvider(
    sendEmojiReactionToConfirmPostUsecase,
    sendQuickShotReactionToConfirmPostUsecase,
    sendCommentReactionToConfirmPostUsecase,
    getAppliedUserListForGroupEntityUsecase,
    sendNotificationToTargetUserUsecase,
    getUserDataFromIdUsecase,
    uploadQuickshotPresetUsecase,
    getQuickshotPresetsUsecase,
    removeQuickshotPresetUsecase,
  );
});

final mainViewModelProvider = StateNotifierProvider.autoDispose<MainViewModelProvider, MainViewModel>((ref) {
  UpdateFCMTokenUsecase updateFCMTokenUsecase = ref.watch(updateFCMTokenUsecaseProvider);
  return MainViewModelProvider(updateFCMTokenUsecase);
});

final signUpAuthDataViewModelProvider =
    StateNotifierProvider.autoDispose<SignUpAuthDataViewModelProvider, SignUpAuthDataViewModel>((ref) {
  return SignUpAuthDataViewModelProvider(ref);
});

// final editUserDataViewModelProvider =
//     StateNotifierProvider.autoDispose<EditUserDataViewModelProvider, EditUserDetailViewModel>((ref) {
//   UploadUserDataUsecase uploadUserDataUsecase = ref.watch(uploadUserDataUsecaseProvider);
//   RemoveCurrentUserDataUsecase removeCurrentUserDataUsecase = ref.watch(removeCurrentUserDataUsecaseProvider);
//   LogOutUsecase logOutUseCase = ref.watch(logOutUseCaseProvider);
//   return EditUserDataViewModelProvider(
//     ref,
//     uploadUserDataUsecase,
//     removeCurrentUserDataUsecase,
//     logOutUseCase,
//   );
// });

final addResolutionViewModelProvider =
    StateNotifierProvider.autoDispose<AddResolutionViewModelProvider, AddResolutionViewModel>((ref) {
  UploadResolutionUseCase uploadResolutionUseCase = ref.watch(uploadResolutionUsecaseProvider);
  return AddResolutionViewModelProvider(
    ref,
    uploadResolutionUseCase,
  );
});

final addResolutionDoneViewModelProvider =
    StateNotifierProvider<AddResolutionDoneViewModelProvider, AddResolutionDoneViewModel>((ref) {
  GetFriendListUsecase getFriendListUsecase = ref.watch(getFriendListUseCaseProvider);
  GetGroupListUsecase getGroupListUsecase = ref.watch(getGroupListUseCaseProvider);
  GetGroupListViewCellWidgetModelUsecase getGroupListViewCellWidgetModelUsecase =
      ref.watch(getGroupListViewCellWidgetModelUsecaseProvider);
  ShareResolutionToFriendUsecase shareResolutionToFriendUsecase = ref.watch(shareResolutionToFriendUsecaseProvider);
  UnshareResolutionToFriendUsecase unshareResolutionToFriendUsecase =
      ref.watch(unshareResolutionToFriendUsecaseProvider);
  ShareResolutionToGroupUsecase shareResolutionToGroupdUsecase = ref.watch(shareResolutionToGroupUsecaseProvider);
  UnshareResolutionToGroupUsecase unshareResolutionToGroupdUsecase = ref.watch(unshareResolutionToGroupUsecaseProvider);
  GetUserDataFromIdUsecase getUserDataFromIdUsecase = ref.watch(getUserDataFromIdUsecaseProvider);

  return AddResolutionDoneViewModelProvider(
    getFriendListUsecase,
    getGroupListUsecase,
    getGroupListViewCellWidgetModelUsecase,
    shareResolutionToFriendUsecase,
    unshareResolutionToFriendUsecase,
    shareResolutionToGroupdUsecase,
    unshareResolutionToGroupdUsecase,
    getUserDataFromIdUsecase,
  );
});

final friendPostViewModelProvider =
    StateNotifierProvider.autoDispose<FriendPostViewModelProvider, FriendPostViewModel>((ref) {
  final getFriendConfirmPostListByDateUsecase = ref.watch(getFriendConfirmPostListByDateUsecaseProvider);
  final sendEmojiReactionToConfirmPostUsecase = ref.watch(sendEmojiReactionToConfirmPostUsecaseProvider);
  final sendQuickShotReactionToConfirmPostUsecase = ref.watch(sendQuickShotReactionToConfirmPostUsecaseProvider);
  final sendCommentReactionToConfirmPostUsecase = ref.watch(sendCommentReactionToConfirmPostUsecaseProvider);
  final sendNotificationToTargetUserUsecase = ref.watch(sendNotificationToTargetUserUsecaseProvider);
  final getUserDataFromIdUsecase = ref.watch(getUserDataFromIdUsecaseProvider);

  return FriendPostViewModelProvider(
    getFriendConfirmPostListByDateUsecase,
    sendEmojiReactionToConfirmPostUsecase,
    sendQuickShotReactionToConfirmPostUsecase,
    sendCommentReactionToConfirmPostUsecase,
    sendNotificationToTargetUserUsecase,
    getUserDataFromIdUsecase,
  );
});

final resolutionDetailViewModelProvider =
    StateNotifierProvider.autoDispose<ResolutionDetailViewModelProvider, ResolutionDetailViewModel>((ref) {
  final GetConfirmPostListForResolutionIdUsecase getConfirmPostListForResolutionIdUsecase =
      ref.watch(getConfirmPostListForResolutionIdUsecaseProvider);
  final GetConfirmPostOfDatetimeFromTargetResolutionUsecase getConfirmPostOfDatetimeFromTargetResolutionUsecase =
      ref.watch(getConfirmPostOfDatetimeFromTargetResolutionUsecaseProvider);
  return ResolutionDetailViewModelProvider(
    getConfirmPostListForResolutionIdUsecase,
    getConfirmPostOfDatetimeFromTargetResolutionUsecase,
  );
});
