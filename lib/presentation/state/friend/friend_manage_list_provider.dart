import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';

final searchedUserUidListProvider = FutureProvider.family<List<String>, String>(
  (ref, handle) => ref.read(searchUserByHandleUsecaseProvider)(handle: handle).then(
        (result) => result.fold(
          (failure) => [],
          (success) => success,
        ),
      ),
);

final appliedUserUidListProvider = FutureProvider<List<String>>(
  (ref) => ref.read(getAppliedUserUidListForFriendUsecaseProvider)().then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);
