import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/group_list_cell.dart';
import 'package:wehavit/presentation/state/friend/friend_list_provider.dart';

final groupListCellModelProvider = FutureProvider.family<GroupListCellModel, GroupEntity>(
  (ref, groupEntity) => ref.read(getGroupListViewCellWidgetModelUsecaseProvider).call(groupEntity: groupEntity).then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

final groupListFriendCellModelProvider = FutureProvider<GroupListCellModel>((ref) async {
  final List<String> friendUidList = await ref.watch(friendUidListProvider.future);

  Map<String, List<String>> sharedResolutionIdMap = {};

  await Future.wait(
    friendUidList.map((uid) async {
      final result = await ref.read(getSharedResolutionIdListFromFriendUidUsecaseProvider).call(targetUid: uid);
      final list = result.fold(
        (failure) => <String>[], // 실패 시 빈 리스트 반환
        (list) => list, // 성공 시 리스트 반환
      );
      sharedResolutionIdMap[uid] = list;
    }),
  );

  final List<String> sharedResolutionIdList = sharedResolutionIdMap.entries.expand((e) => e.value).toList();

  return ref
      .read(getGroupListViewFriendCellWidgetModelUsecaseProvider)
      .call(friendUidList: friendUidList, sharedResolutionIdList: sharedResolutionIdList)
      .then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) {
            return success.copyWith(sharedResolutionCount: sharedResolutionIdList.length);
          },
        ),
      );
});
