import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/domain.dart';

// class MyUserDataNotifier extends StateNotifier<UserDataEntity> {
//   MyUserDataNotifier({
//     required this.getMyUserDataUsecase,
//   }) : super(UserDataEntity.dummyModel);

//   final GetMyUserDataUsecase getMyUserDataUsecase;
// }

// final myUserDataStateProvider = StateNotifierProvider<MyUserDataNotifier, UserDataEntity>(
//   (ref) => MyUserDataNotifier(
//     getMyUserDataUsecase: ref.read(getMyUserDataUsecaseProvider),
//   ),
// );

final getMyUserDataProvider = FutureProvider.autoDispose<UserDataEntity>(
  (ref) => ref.read(getMyUserDataUsecaseProvider).call().then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);
