import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multiselect/multiselect.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/friend_entity/friend_model.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';
import 'package:wehavit/presentation/my_page/presentation/providers/add_resolution_provider.dart';
import 'package:wehavit/presentation/my_page/presentation/providers/my_page_resolution_list_provider.dart';

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
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.whDarkBlack,
        title: const Text(
          '새로운 목표 추가',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
            color: CustomColors.whWhite,
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColors.whDarkBlack,
                  CustomColors.whYellowDark,
                  CustomColors.whYellow,
                ],
                stops: [0.3, 0.8, 1.2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            minimum: EdgeInsets.all(16.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '나의 목표',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomColors.whYellowDark,
                                width: 3.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomColors.whBlack,
                                width: 3.0,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            fillColor: CustomColors.whSemiWhite,
                            filled: true,
                          ),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whDarkBlack,
                          ),
                          onChanged: (value) {
                            ref
                                .read(addResolutionProvider.notifier)
                                .changeGoalStatement(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '실천할 행동',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomColors.whYellowDark,
                                width: 3.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomColors.whBlack,
                                width: 3.0,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            fillColor: CustomColors.whSemiWhite,
                            filled: true,
                          ),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whDarkBlack,
                          ),
                          onChanged: (value) {
                            ref
                                .read(addResolutionProvider.notifier)
                                .changeActionStatement(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              '실천 주기',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.whWhite,
                              ),
                            ),
                          ),
                          Row(
                            children: Iterable<int>.generate(7).map((idx) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: resolutionProvider
                                              .isDaySelectedList![idx]
                                          ? CustomColors.whYellow
                                          : CustomColors.whYellowBright,
                                    ),
                                    onPressed: () {
                                      List<bool> newSelectedDayList =
                                          resolutionProvider.isDaySelectedList!;
                                      newSelectedDayList[idx] =
                                          !newSelectedDayList[idx];

                                      ref
                                          .read(addResolutionProvider.notifier)
                                          .changePeriodState(
                                              newSelectedDayList);
                                    },
                                    child: Text(
                                      dayList[idx],
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: CustomColors.whDarkBlack,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '인증을 공유할 친구',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                          ),
                        ),
                      ),
                      const SelectFans(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '나의 다짐 한마디',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomColors.whYellowDark,
                                width: 3.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomColors.whBlack,
                                width: 3.0,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            fillColor: CustomColors.whSemiWhite,
                            filled: true,
                          ),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whDarkBlack,
                          ),
                          onChanged: (value) {
                            ref
                                .read(addResolutionProvider.notifier)
                                .changeOathStatement(value);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.whYellow,
                        ),
                        onPressed: () async {
                          ref
                              .read(addResolutionProvider.notifier)
                              .uploadResolutionModel()
                              .then(
                            (result) {
                              result.fold((failure) {
                                debugPrint(
                                  'DEBUG : UPLOAD FAILED - ${failure.message}',
                                );
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
                          '기록 남기기',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.whDarkBlack,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropDownMultiSelect<String>(
        onChanged: (currentSelected) {
          final friendList = friendListSnapshot.data
              ?.where((element) => currentSelected.contains(element.friendName))
              .toList();
          ref
              .read(addResolutionProvider.notifier)
              .changeFanList(friendList ?? []);
        },
        options: friendListSnapshot.data?.map((e) => e.friendName!).toList() ??
            ['친구를 불러오는 중입니다.'],
        selectedValues:
            resolutionState.fanList!.map((e) => e.friendName!).toList(),
        whenEmpty: '친구를 선택해주세요.',
        // 스타일링을 위한 코드
        selected_values_style: const TextStyle(
            color: CustomColors.whBlack,
            fontSize: 16.0,
            fontWeight: FontWeight.w500),
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
