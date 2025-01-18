import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';

final searchedUserUidListProvider = FutureProvider.family.autoDispose<List<String>, String>(
  (ref, handle) => ref.read(searchUserByHandleUsecaseProvider).call(handle: handle).then(
        (result) => result.fold(
          (failure) => [],
          (success) => success,
        ),
      ),
);

final appliedUserUidListProvider = FutureProvider.autoDispose<List<String>>(
  (ref) => ref.read(getAppliedUserUidListForFriendUsecaseProvider).call().then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);
