import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/dependency/data/repository_dependency.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/get_group_list_view_cell_widget_model_usecase.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/auth/auth.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/friend_list/friend_list.dart';
import 'package:wehavit/presentation/group/group.dart';
import 'package:wehavit/presentation/home/home.dart';
import 'package:wehavit/presentation/late_writing/late_writing.dart';
import 'package:wehavit/presentation/my_page/my_page.dart';
import 'package:wehavit/presentation/reaction/provider/provider.dart';

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

final lateWritingViewModelProvider =
    StateNotifierProvider<LateWritingViewModelProvider, LateWritingViewModel>(
  (ref) {
    final createPostUsecase = ref.watch(uploadConfirmPostUseCaseProvider);
    final getMyResolutionListUsecase =
        ref.watch(getMyResolutionListByUserIdUsecaseProvider);

    return LateWritingViewModelProvider(
      createPostUsecase,
      getMyResolutionListUsecase,
    );
  },
);

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
