import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';

final friendUidListProvider = FutureProvider<List<String>>(
  (ref) => ref.read(getFriendUidListUseCaseProvider).call().then(
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
