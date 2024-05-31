import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/data/repository_dependency.dart';
import 'package:wehavit/domain/usecases/get_group_list_view_cell_widget_model_usecase.dart';
import 'package:wehavit/domain/usecases/get_to_whom_resolution_will_be_shared_usecase.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

final logOutUseCaseProvider = Provider<LogOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LogOutUseCase(authRepository);
});

final googleLogOutUseCaseProvider = Provider<GoogleLogOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoogleLogOutUseCase(authRepository);
});

final googleLogInUseCaseProvider = Provider<LogInWithGoogleUsecase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LogInWithGoogleUsecase(authRepository);
});

final emailAndPasswordRegisterUseCaseProvider =
    Provider<SignUpWithEmailAndPasswordUsecase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpWithEmailAndPasswordUsecase(authRepository);
});

final emailAndPasswordLogInUseCaseProvider =
    Provider<LogInWithEmailAndPasswordUsecase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LogInWithEmailAndPasswordUsecase(authRepository);
});

// final authStateChangesUseCaseProvider = Provider<AuthStateChangesUseCase>(
//   (ref) {
//     final authRepository = ref.watch(authRepositoryProvider);
//     return AuthStateChangesUseCase(authRepository);
//   },
// );

final uploadResolutionUsecaseProvider =
    Provider<UploadResolutionUseCase>((ref) {
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return UploadResolutionUseCase(
    resolutionRepository,
    userModelRepository,
  );
});

final registerFriendUsecaseProvider = Provider<RegisterFriendUsecase>((ref) {
  final friendRepository = ref.watch(friendRepositoryProvider);
  return RegisterFriendUsecase(friendRepository);
});

final uploadConfirmPostUseCaseProvider = Provider<UploadConfirmPostUseCase>(
  (ref) => UploadConfirmPostUseCase(
    ref.watch(confirmPostRepositoryProvider),
    ref.watch(userModelRepositoryProvider),
  ),
);

final sendQuickShotReactionToConfirmPostUsecaseProvider =
    Provider<SendQuickShotReactionToConfirmPostUsecase>((ref) {
  final reactionRepository = ref.watch(reactionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  final photoRepository = ref.watch(photoRepositoryProvider);

  return SendQuickShotReactionToConfirmPostUsecase(
    reactionRepository,
    userModelRepository,
    photoRepository,
  );
});

final sendEmojiReactionToConfirmPostUsecaseProvider =
    Provider<SendEmojiReactionToConfirmPostUsecase>((ref) {
  final reactionRepository = ref.watch(reactionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return SendEmojiReactionToConfirmPostUsecase(
    reactionRepository,
    userModelRepository,
  );
});

final sendCommentReactionToConfirmPostUsecaseProvider =
    Provider<SendCommentReactionToConfirmPostUsecase>((ref) {
  final reactionRepository = ref.watch(reactionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return SendCommentReactionToConfirmPostUsecase(
    reactionRepository,
    userModelRepository,
  );
});

final getUnreadReactionListUsecaseProvider =
    Provider<GetUnreadReactionListUsecase>((ref) {
  final repository = ref.watch(reactionRepositoryProvider);
  return GetUnreadReactionListUsecase(repository);
});

final getResolutionListByUserIdUsecaseProvider =
    Provider<GetResolutionListByUserIdUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetResolutionListByUserIdUsecase(resolutionRepository);
});

final getReactionListFromConfirmPostUsecaseProvider =
    Provider<GetReactionListFromConfirmPostUsecase>((ref) {
  final repository = ref.watch(reactionRepositoryProvider);
  return GetReactionListFromConfirmPostUsecase(repository);
});

final getMyResolutionListUsecaseProvider =
    Provider<GetMyResolutionListUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return GetMyResolutionListUsecase(
    resolutionRepository,
    userModelRepository,
  );
});

final getFriendListUseCaseProvider = Provider<GetFriendListUsecase>((ref) {
  final resolutionRepository = ref.watch(friendRepositoryProvider);
  return GetFriendListUsecase(resolutionRepository);
});

final getGroupConfirmPostListByDateUsecaseProvider =
    Provider<GetGroupConfirmPostListByDateUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetGroupConfirmPostListByDateUsecase(confirmPostRepository);
});

final getConfirmPostListForResolutionIdUsecaseProvider =
    Provider<GetConfirmPostListForResolutionIdUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetConfirmPostListForResolutionIdUsecase(confirmPostRepository);
});

final getUserDataFromIdUsecaseProvider =
    Provider<GetUserDataFromIdUsecase>((ref) {
  final repository = ref.watch(userModelRepositoryProvider);
  return GetUserDataFromIdUsecase(repository);
});

final getMyUserDataUsecaseProvider = Provider<GetMyUserDataUsecase>((ref) {
  final repository = ref.watch(userModelRepositoryProvider);
  return GetMyUserDataUsecase(repository);
});

final createGroupUsecaseProvider = Provider<CreateGroupUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return CreateGroupUsecase(groupRepository, userModelRepository);
});

final applyForJoiningGroupUsecaseProvider =
    Provider<ApplyForJoiningGroupUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return ApplyForJoiningGroupUsecase(groupRepository);
});

final acceptApplyingForJoiningGroupUsecaseProvider =
    Provider<AcceptApplyingForJoiningGroupUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return AcceptApplyingForJoiningGroupUsecase(groupRepository);
});

final rejectApplyingForJoiningGroupUsecaseProvider =
    Provider<RejectApplyingForJoiningGroupUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return RejectApplyingForJoiningGroupUsecase(groupRepository);
});

final withdrawalFromGroupUsecaseProvider =
    Provider<WithdrawalTargetUserFromGroupUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return WithdrawalTargetUserFromGroupUsecase(groupRepository);
});

final getGroupListUseCaseProvider = Provider<GetGroupListUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return GetGroupListUsecase(groupRepository);
});

final uploadGroupAnnouncementUsecaseProvider =
    Provider<UploadGroupAnnouncementUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return UploadGroupAnnouncementUsecase(groupRepository, userModelRepository);
});

final getGroupAnnouncementListUsecaseProvider =
    Provider<GetGroupAnnouncementListUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return GetGroupAnnouncementListUsecase(groupRepository);
});

final readGroupAnnouncementUsecaseProvider =
    Provider<ReadGroupAnnouncementUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return ReadGroupAnnouncementUsecase(groupRepository);
});

final getGroupWeeklyReportUsecaseProvider =
    Provider<GetGroupWeeklyReportUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return GetGroupWeeklyReportUsecase(groupRepository);
});

final getGroupListViewCellWidgetModelUsecaseProvider =
    Provider<GetGroupListViewCellWidgetModelUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return GetGroupListViewCellWidgetModelUsecase(groupRepository);
});

final getGroupEntityByIdUsecaseProvider =
    Provider<GetGroupEntityByIdUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return GetGroupEntityByIdUsecase(groupRepository);
});

final checkWhetherAlreadyRegisteredToGroupUsecaseProvider =
    Provider<CheckWhetherAlreadyRegisteredToGroupUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return CheckWhetherAlreadyRegisteredToGroupUsecase(groupRepository);
});

final checkWhetherAlreadyAppliedToGroupUsecaseProvider =
    Provider<CheckWhetherAlreadyAppliedToGroupUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return CheckWhetherAlreadyAppliedToGroupUsecase(groupRepository);
});

final getTargetResolutionDoneListForWeekUsecaseProvider =
    Provider<GetTargetResolutionDoneListForWeekUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetTargetResolutionDoneListForWeekUsecase(resolutionRepository);
});

final getToWhomResolutionWillBeSharedUsecaseProvider =
    Provider<GetToWhomResolutionWillBeSharedUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetToWhomResolutionWillBeSharedUsecase(resolutionRepository);
});

final checkWeatherUserIsMnagerOfGroupEntityUsecaseProvider =
    Provider<CheckWeatherUserIsMnagerOfGroupEntityUsecase>((ref) {
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return CheckWeatherUserIsMnagerOfGroupEntityUsecase(
    userModelRepository,
  );
});

final getAppliedUserListForGroupEntityUsecaseProvider =
    Provider<GetAppliedUserListForGroupEntityUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return GetAppliedUserListForGroupEntityUsecase(groupRepository);
});

final getAchievementPercentageForGroupMemberUsecaseProvider =
    Provider<GetAchievementPercentageForGroupMemberUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return GetAchievementPercentageForGroupMemberUsecase(groupRepository);
});

final getTargetResolutionEntityUsecaseProvider =
    Provider<GetTargetResolutionEntityUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetTargetResolutionEntityUsecase(resolutionRepository);
});

final updateAboutMeUsecaseProvider = Provider<UpdateAboutMeUsecase>((ref) {
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return UpdateAboutMeUsecase(userModelRepository);
});

final getAppliedUserListForFriendUsecaseProvider =
    Provider<GetAppliedUserListForFriendUsecase>((ref) {
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return GetAppliedUserListForFriendUsecase(userModelRepository);
});

final applyForUserFriendUsecaseProvider =
    Provider<ApplyForUserFriendUsecase>((ref) {
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return ApplyForUserFriendUsecase(userModelRepository);
});

final removeFriendUsecaseProvider = Provider<RemoveFriendUsecase>((ref) {
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return RemoveFriendUsecase(userModelRepository);
});

final searchUserDataListByNicknameUsecaseProvider =
    Provider<SearchUserDataListByNicknameUsecase>((ref) {
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return SearchUserDataListByNicknameUsecase(userModelRepository);
});
final acceptApplyingForFriendUsecaseProvider =
    Provider<AcceptApplyingForFriendUsecase>((ref) {
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return AcceptApplyingForFriendUsecase(userModelRepository);
});

final rejectApplyingForFriendUsecaseProvider =
    Provider<RejectApplyingForFriendUsecase>((ref) {
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return RejectApplyingForFriendUsecase(userModelRepository);
});

final signUpWithEmailAndPasswordUsecase =
    Provider<SignUpWithEmailAndPasswordUsecase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpWithEmailAndPasswordUsecase(authRepository);
});
