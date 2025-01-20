import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/state/group_list/group_list_provider.dart';

final searchGroupProvider = FutureProvider.autoDispose.family<List<GroupEntity>, String>(
  (ref, groupName) => ref.read(searchGroupEntityListByGroupNameUsecaseProvider).call(searchKeyword: groupName).then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

final groupApplyStateProvider = FutureProvider.autoDispose.family<bool, String>(
  (ref, groupId) => ref.read(checkWhetherAlreadyAppliedToGroupUsecaseProvider).call(groupId).then(
        (value) => value.fold(
          (failure) => Future.error(failure.message),
          (isApplied) => isApplied,
        ),
      ),
);

final groupRegisterStateProvider = FutureProvider.autoDispose.family<bool, String>(
  (ref, groupId) {
    return ref.read(groupListProvider.future).then(
          (list) => list.any(
            (entity) => entity.groupId == groupId,
          ),
        );
  },
);
