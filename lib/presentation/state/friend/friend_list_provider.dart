import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';

final friendUidListProvider = FutureProvider<List<String>>(
  (ref) => ref.read(getFriendUidListUseCaseProvider).call().then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

final userDataEntityProvider = FutureProvider.family<UserDataEntity, String>(
  (ref, userId) => ref.read(getUserDataFromIdUsecaseProvider).call(userId).then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

// final friendListProvider = FutureProvider<List<UserDataEntity>>(
//   (ref) => ref.read(getFriendListUseCaseProvider).call().then(
//         (result) => result.fold(
//           (failure) => Future.error(failure.message),
//           (success) => success,
//         ),
//       ),
// );
