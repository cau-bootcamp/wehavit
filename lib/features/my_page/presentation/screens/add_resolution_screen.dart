import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multiselect/multiselect.dart';
import 'package:wehavit/common/common.dart';
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
        shadowColor: CustomColors.whBlack,
        foregroundColor: CustomColors.whBlack,
        backgroundColor: CustomColors.whBlack,
      ),
      body: Container(
        color: CustomColors.whBlack,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                height: 40,
                width: 120,
                decoration: const BoxDecoration(
                  color: CustomColors.whYellowDark,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '나의 목표',
                  style: TextStyle(
                    color: CustomColors.whWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                onChanged: (value) {
                  ref
                      .read(addResolutionProvider.notifier)
                      .changeGoalStatement(value);
                },
              ),
              Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text('내 목표를 공유할 친구들'),
                    ),
                    const SelectFans(),
                  ],
                ),
              ),
              Column(
                children: [
                  const Text('실천할 행동'),
                  TextField(
                    onChanged: (value) {
                      ref
                          .read(addResolutionProvider.notifier)
                          .changeActionStatement(value);
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
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
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('나의 다짐'),
                    TextField(
                      onChanged: (value) {
                        ref
                            .read(addResolutionProvider.notifier)
                            .changeOathStatement(value);
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref
                      .read(addResolutionProvider.notifier)
                      .uploadResolutionModel()
                      .then(
                    (result) {
                      result.fold((failure) {
                        debugPrint(
                            'DEBUG : UPLOAD FAILED - ${failure.message}');
                      }, (success) {
                        ref
                            .read(myPageResolutionListProvider.notifier)
                            .getActiveResolutionList();
                        context.pop();
                      });
                    },
                  );
                },
                child: const Text(
                  'UPLOAD Button',
                  style: TextStyle(color: CustomColors.whYellowDark),
                ),
              ),
            ],
          ),
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
      // 스타일링을 위한 코드
      selected_values_style: const TextStyle(
        color: CustomColors.whWhite,
      ),
      decoration: InputDecoration(
        fillColor: CustomColors.whYellow,
        // 배경 색상
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        // 패딩
        border: OutlineInputBorder(
          // 테두리 설정
          borderRadius: BorderRadius.circular(36), // 둥근 테두리
          borderSide: const BorderSide(
            color: CustomColors.whYellow, // 테두리 색상
            width: 2, // 테두리 두께
          ),
        ),
        // 선택된 아이템의 스타일 변경 (옵션)
        labelStyle: const TextStyle(
          color: CustomColors.whWhite, // 레이블 글자 색상
          fontWeight: FontWeight.bold, // 레이블 글자 굵기
        ),
      ),
    );
  }
}

Future<List<FriendModel>> getFriendList(WidgetRef ref) {
  return ref.read(friendRepositoryProvider).getFriendModelList().then(
    (result) {
      return result.fold((failure) {
        return [];
      }, (success) {
        return success;
      });
    },
  );
}
