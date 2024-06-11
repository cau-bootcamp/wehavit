import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/data/repository_dependency.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
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

final friendListViewModelProvider =
    StateNotifierProvider<FriendListViewModelProvider, FriendListViewModel>(
        (ref) {
  final getFriendListUsecase = ref.read(getFriendListUseCaseProvider);
  final searchUserDataListByNicknameUsecase =
      ref.read(searchUserDataListByNicknameUsecaseProvider);
  final getMyUserDataUsecase = ref.read(getMyUserDataUsecaseProvider);
  final getAppliedUserListForFriendUsecase =
      ref.read(getAppliedUserListForFriendUsecaseProvider);
  final AcceptApplyingForFriendUsecase acceptApplyingForFriendUsecase =
      ref.read(acceptApplyingForFriendUsecaseProvider);
  final RejectApplyingForFriendUsecase rejectApplyingForFriendUsecase =
      ref.read(rejectApplyingForFriendUsecaseProvider);
  final RemoveFriendUsecase removeFriendUsecase =
      ref.read(removeFriendUsecaseProvider);
  final ApplyForUserFriendUsecase applyForUserFriendUsecase =
      ref.read(applyForUserFriendUsecaseProvider);
  final GetUserDataFromIdUsecase getUserDataFromIdUsecase =
      ref.read(getUserDataFromIdUsecaseProvider);
  return FriendListViewModelProvider(
    getFriendListUsecase,
    searchUserDataListByNicknameUsecase,
    getMyUserDataUsecase,
    getAppliedUserListForFriendUsecase,
    acceptApplyingForFriendUsecase,
    rejectApplyingForFriendUsecase,
    removeFriendUsecase,
    applyForUserFriendUsecase,
    getUserDataFromIdUsecase,
  );
});

final addResolutionProvider =
    StateNotifierProvider.autoDispose<AddResolutionNotifier, ResolutionEntity>(
        (ref) {
  return AddResolutionNotifier(ref);
});

final myPageViewModelProvider =
    StateNotifierProvider<MyPageViewModelProvider, MyPageViewModel>((ref) {
  final getMyResolutionListUsecase =
      ref.watch(getMyResolutionListUsecaseProvider);
  final getMyUserDataUsecase = ref.watch(getMyUserDataUsecaseProvider);

  return MyPageViewModelProvider(
    getMyResolutionListUsecase,
    getMyUserDataUsecase,
  );
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
      ref.watch(getTargetResolutionDoneListForWeekUsecaseProvider);
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
  final getGroupConfirmPostListByDateUsecase =
      ref.watch(getGroupConfirmPostListByDateUsecaseProvider);
  final sendEmojiReactionToConfirmPostUsecase =
      ref.watch(sendEmojiReactionToConfirmPostUsecaseProvider);
  final sendQuickShotReactionToConfirmPostUsecase =
      ref.watch(sendQuickShotReactionToConfirmPostUsecaseProvider);
  final sendCommentReactionToConfirmPostUsecase =
      ref.watch(sendCommentReactionToConfirmPostUsecaseProvider);
  final getAppliedUserListForGroupEntityUsecase =
      ref.watch(getAppliedUserListForGroupEntityUsecaseProvider);
  return GroupPostViewModelProvider(
    getGroupConfirmPostListByDateUsecase,
    sendEmojiReactionToConfirmPostUsecase,
    sendQuickShotReactionToConfirmPostUsecase,
    sendCommentReactionToConfirmPostUsecase,
    getAppliedUserListForGroupEntityUsecase,
  );
});

final mainViewModelProvider =
    StateNotifierProvider.autoDispose<MainViewModelProvider, MainViewModel>(
        (ref) {
  return MainViewModelProvider();
});

final signUpAuthDataViewModelProvider = StateNotifierProvider.autoDispose<
    SignUpAuthDataViewModelProvider, SignUpAuthDataViewModel>((ref) {
  return SignUpAuthDataViewModelProvider();
});

final signUpUserDataViewModelProvider = StateNotifierProvider.autoDispose<
    SignUpUserDataViewModelProvider, SignUpUserDataViewModel>((ref) {
  UploadUserDataUsecase uploadUserDataUsecase =
      ref.watch(uploadUserDataUsecaseProvider);
  RemoveCurrentUserDataUsecase removeCurrentUserDataUsecase =
      ref.watch(removeCurrentUserDataUsecaseProvider);
  LogOutUseCase logOutUseCase = ref.watch(logOutUseCaseProvider);
  return SignUpUserDataViewModelProvider(
    uploadUserDataUsecase,
    removeCurrentUserDataUsecase,
    logOutUseCase,
  );
});

final logInViewModelProvider =
    StateNotifierProvider.autoDispose<LogInViewModelProvider, LogInViewModel>(
        (ref) {
  LogInWithEmailAndPasswordUsecase logInWithEmailAndPasswordUsecase =
      ref.watch(logInWithEmailAndPasswordUsecaseProvider);

  return LogInViewModelProvider(logInWithEmailAndPasswordUsecase);
});

final addResolutionViewModelProvider = StateNotifierProvider.autoDispose<
    AddResolutionViewModelProvider, AddResolutionViewModel>((ref) {
  UploadResolutionUseCase uploadResolutionUseCase =
      ref.watch(uploadResolutionUsecaseProvider);
  return AddResolutionViewModelProvider(uploadResolutionUseCase);
});

final addResolutionDoneViewModelProvider = StateNotifierProvider.autoDispose<
    AddResolutionDoneViewModelProvider, AddResolutionDoneViewModel>((ref) {
  GetFriendListUsecase getFriendListUsecase =
      ref.watch(getFriendListUseCaseProvider);
  GetGroupListUsecase getGroupListUsecase =
      ref.watch(getGroupListUseCaseProvider);
  GetGroupListViewCellWidgetModelUsecase
      getGroupListViewCellWidgetModelUsecase =
      ref.watch(getGroupListViewCellWidgetModelUsecaseProvider);
  ShareResolutionToFriendUsecase shareResolutionToFriendUsecase =
      ref.watch(shareResolutionToFriendUsecaseProvider);
  UnshareResolutionToFriendUsecase unshareResolutionToFriendUsecase =
      ref.watch(unshareResolutionToFriendUsecaseProvider);
  ShareResolutionToGroupUsecase shareResolutionToGroupdUsecase =
      ref.watch(shareResolutionToGroupUsecaseProvider);
  UnshareResolutionToGroupUsecase unshareResolutionToGroupdUsecase =
      ref.watch(unshareResolutionToGroupUsecaseProvider);

  return AddResolutionDoneViewModelProvider(
    getFriendListUsecase,
    getGroupListUsecase,
    getGroupListViewCellWidgetModelUsecase,
    shareResolutionToFriendUsecase,
    unshareResolutionToFriendUsecase,
    shareResolutionToGroupdUsecase,
    unshareResolutionToGroupdUsecase,
  );
});
