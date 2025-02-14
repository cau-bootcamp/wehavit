import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/state/friend/friend_list_provider.dart';

final friendSharedResolutionListProvider = FutureProvider<List<String>>(
  (ref) async {
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

    // 내가 작성한 포스트도 함께 보여주기
    final result = await ref.read(getMyResolutionListUsecaseProvider).call();
    final list = result.fold(
      (failure) => <String>[], // 실패 시 빈 리스트 반환
      (list) => list.map((e) => e.resolutionId).toList(), // 성공 시 리스트 반환
    );
    sharedResolutionIdMap[''] = list;

    final List<String> sharedResolutionIdList = sharedResolutionIdMap.entries.expand((e) => e.value).toList();

    return sharedResolutionIdList;
  },
);

final friendPostListProvider = FutureProvider.family<List<ConfirmPostEntity>, DateTime>(
  (ref, date) async {
    final postListProvider = ref
        .watch(friendSharedResolutionListProvider)
        .when(data: (data) => data, error: (_, __) => List<String>.empty(), loading: () => List<String>.empty());

    return ref
        .read(getFriendConfirmPostListByDateUsecaseProvider)
        .call(
          postListProvider,
          date,
        )
        .then(
          (result) => result.fold(
            (failure) => Future.error(failure.message),
            (success) => success,
          ),
        );
  },
);
