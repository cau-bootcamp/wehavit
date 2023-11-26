import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multiselect/multiselect.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';
import 'package:wehavit/features/friend_list/domain/repositories/friend_repository_provider.dart';
import 'package:wehavit/features/my_page/presentation/providers/add_resolution_provider.dart';
import 'package:wehavit/features/my_page/presentation/providers/my_page_resolution_list_provider.dart';

// 여기에 뷰가 적용되면 수정할 예정임.
class AddResolutionScreen extends HookConsumerWidget {
  const AddResolutionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolutionProvider = ref.watch(addResolutionProvider);
    final dayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    // ignore: discarded_futures
    final friendListFuture = useMemoized(() => getFriendList(ref));
    final friendListSnapshot = useFuture(friendListFuture);

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('나의 목표'),
            TextField(
              onChanged: (value) {
                ref
                    .read(addResolutionProvider.notifier)
                    .changeGoalStatement(value);
              },
            ),
            const Text('내 목표를 공유할 친구들'),
            SelectFans(),
            const Text('실천할 행동'),
            TextField(
              onChanged: (value) {
                ref
                    .read(addResolutionProvider.notifier)
                    .changeActionStatement(value);
              },
            ),
            const Text('실천 주기'),
            Row(
              children: Iterable<int>.generate(7).map((idx) {
                return Expanded(
                  child: TextButton(
                    onPressed: () {
                      ref
                          .read(addResolutionProvider.notifier)
                          .changePeriodState(idx);
                    },
                    child: Text(
                      dayList[idx],
                      style: TextStyle(
                        color: resolutionProvider.isDaySelectedList[idx]
                            ? Colors.red
                            : Colors.cyan,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const Text('나의 다짐'),
            TextField(
              onChanged: (value) {
                ref
                    .read(addResolutionProvider.notifier)
                    .changeOathStatement(value);
              },
            ),
            ElevatedButton(
              onPressed: () async {
                ref
                    .read(addResolutionProvider.notifier)
                    .uploadResolutionModel()
                    .then(
                  (result) {
                    result.fold((failure) {
                      debugPrint('DEBUG : UPLOAD FAILED - ${failure.message}');
                    }, (success) {
                      ref
                          .read(myPageResolutionListProvider.notifier)
                          .getActiveResolutionList();
                      context.pop();
                    });
                  },
                );
              },
              child: const Text('UPLOAD Button'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectFans extends HookConsumerWidget {
  const SelectFans({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolutionState = ref.watch(addResolutionProvider);
    // ignore: discarded_futures
    final friendListFuture = useMemoized(() => getFriendList(ref));
    final friendListSnapshot = useFuture(friendListFuture);

    return DropDownMultiSelect<String>(
      onChanged: (currentSelected) {
        final friendList = friendListSnapshot.data
            ?.where((element) => currentSelected.contains(element.friendName))
            .toList();
        ref
            .read(addResolutionProvider.notifier)
            .changeFanList(friendList ?? []);
      },
      options: friendListSnapshot.data?.map((e) => e.friendName).toList() ??
          ['친구를 불러오는 중입니다.'],
      selectedValues: resolutionState.fanList.map((e) => e.friendName).toList(),
      whenEmpty: '친구를 선택해주세요.',
    );
  }
}

Future<List<FriendModel>> getFriendList(WidgetRef ref) {
  return ref.read(friendRepositoryProvider).getFriendModelList().then(
    (result) {
      return result.fold((failure) {
        debugPrint('DEBUG : ${failure.message}');
        return [];
      }, (success) {
        debugPrint('DEBUG : $success');
        return success;
      });
    },
  );
}
