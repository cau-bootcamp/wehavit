import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/data/repository_dependency.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';
import 'package:wehavit/domain/usecases/accept_applying_for_joining_group_usecase.dart';
import 'package:wehavit/domain/usecases/apply_for_joining_group_usecase.dart';
import 'package:wehavit/domain/usecases/create_group_usecase.dart';
import 'package:wehavit/domain/usecases/get_group_announcement_list_usecase.dart';
import 'package:wehavit/domain/usecases/get_group_list_usecase.dart';
import 'package:wehavit/domain/usecases/reject_applying_for_joining_group_usecase.dart';
import 'package:wehavit/domain/usecases/upload_group_announcement_usecase.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/domain/usecases/withdrawal_from_group_usecase.dart';

final logOutUseCaseProvider = Provider<LogOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LogOutUseCase(authRepository);
});

final googleLogOutUseCaseProvider = Provider<GoogleLogOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoogleLogOutUseCase(authRepository);
});

final googleLogInUseCaseProvider = Provider<GoogleLogInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoogleLogInUseCase(authRepository);
});

final emailAndPasswordRegisterUseCaseProvider =
    Provider<EmailAndPasswordRegisterUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailAndPasswordRegisterUseCase(authRepository);
});

final emailAndPasswordLogInUseCaseProvider =
    Provider<EmailAndPasswordLogInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailAndPasswordLogInUseCase(authRepository);
});

final authStateChangesUseCaseProvider = Provider<AuthStateChangesUseCase>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthStateChangesUseCase(authRepository);
  },
);

final uploadResolutionUsecaseProvider =
    Provider<UploadResolutionUseCase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return UploadResolutionUseCase(resolutionRepository);
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

final getMyResolutionListByUserIdUsecaseProvider =
    Provider<GetMyResolutionListByUserIdUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return GetMyResolutionListByUserIdUsecase(
    resolutionRepository,
    userModelRepository,
  );
});

final getFriendListUseCaseProvider = Provider<GetFriendListUsecase>((ref) {
  final resolutionRepository = ref.watch(friendRepositoryProvider);
  return GetFriendListUsecase(resolutionRepository);
});

final getConfirmPostListUsecaseProvider =
    Provider<GetConfirmPostListUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetConfirmPostListUsecase(confirmPostRepository);
});

final getConfirmPostListForResolutionIdUsecaseProvider =
    Provider<GetConfirmPostListForResolutionIdUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetConfirmPostListForResolutionIdUsecase(confirmPostRepository);
});

final fetchUserDataFromIdUsecaseProvider =
    Provider<FetchUserDataFromIdUsecase>((ref) {
  final repository = ref.watch(userModelRepositoryProvider);
  return FetchUserDataFromIdUsecase(repository);
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
    Provider<WithdrawalFromGroupUsecase>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return WithdrawalFromGroupUsecase(groupRepository);
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
