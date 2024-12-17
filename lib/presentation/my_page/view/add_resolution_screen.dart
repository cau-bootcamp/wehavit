import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

// 여기에 뷰가 적용되면 수정할 예정임.
class AddResolutionScreen extends HookConsumerWidget {
  const AddResolutionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final resolutionProvider = ref.watch(addResolutionProvider);

    // ignore: discarded_futures
    // final friendListFuture = useMemoized(() => getFriendList(ref));
    // final friendListSnapshot = useFuture(friendListFuture);

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
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            fillColor: CustomColors.whSemiWhite,
                            filled: true,
                          ),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whDarkBlack,
                          ),
                          onChanged: (value) {
                            ref.read(addResolutionProvider.notifier).changeGoalStatement(value);
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
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            fillColor: CustomColors.whSemiWhite,
                            filled: true,
                          ),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whDarkBlack,
                          ),
                          onChanged: (value) {
                            ref.read(addResolutionProvider.notifier).changeActionStatement(value);
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
                          Container(
                            height: 100,
                            child: WheelChooser.custom(
                              horizontal: true,
                              onValueChanged: (a) =>
                                  ref.read(addResolutionProvider.notifier).changeActionPerWeekState(a + 1),
                              children: List<Widget>.generate(
                                7,
                                (index) => Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Text(
                                    (index + 1).toString(),
                                  ),
                                ),
                              ),
                            ),
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
                      // const SelectFans(),
                      // const SelectGroups(),
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
                          // ref
                          //     .read(addResolutionProvider.notifier)
                          //     .uploadResolutionEntity()
                          //     .then(
                          //   (result) {
                          //     result.fold((failure) {
                          //       debugPrint(
                          //         'DEBUG : UPLOAD FAILED - ${failure.message}',
                          //       );
                          //     }, (success) {
                          //       ref
                          //           .read(myPageViewModelProvider.notifier)
                          //           .loadData();
                          //       context.pop();
                          //     });
                          //   },
                          // );
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

// class SelectFans extends HookConsumerWidget {
//   const SelectFans({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final resolutionState = ref.watch(addResolutionProvider);
//     // ignore: discarded_futures
//     final friendListFuture = useMemoized(() => getFriendList(ref));
//     final friendListSnapshot = useFuture(friendListFuture);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: DropDownMultiSelect<String>(
//         onChanged: (currentSelected) {
//           final friendList = friendListSnapshot.data
//               ?.where((element) => currentSelected.contains(element.userName))
//               .toList();
//           ref
//               .read(addResolutionProvider.notifier)
//               .changeFanList(friendList ?? []);
//         },
//         options: friendListSnapshot.data?.map((e) => e.userName!).toList() ??
//             ['친구를 불러오는 중입니다.'],
//         selectedValues: (resolutionState.shareFriendEntityList ?? [])
//             .map((e) => e.userName!)
//             .toList(),
//         whenEmpty: '친구를 선택해주세요.',
//         // 스타일링을 위한 코드
//         selected_values_style: const TextStyle(
//             color: CustomColors.whBlack,
//             fontSize: 16.0,
//             fontWeight: FontWeight.w500),
//         decoration: InputDecoration(
//           fillColor: CustomColors.whYellow,
//           // 배경 색상
//           filled: true,
//           contentPadding: const EdgeInsets.all(10),
//           // 패딩
//           border: OutlineInputBorder(
//             // 테두리 설정
//             borderRadius: BorderRadius.circular(36), // 둥근 테두리
//             borderSide: const BorderSide(
//               color: CustomColors.whYellow, // 테두리 색상
//               width: 2, // 테두리 두께
//             ),
//           ),
//           // 선택된 아이템의 스타일 변경 (옵션)
//           labelStyle: const TextStyle(
//             color: CustomColors.whWhite, // 레이블 글자 색상
//             fontWeight: FontWeight.bold, // 레이블 글자 굵기
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SelectGroups extends HookConsumerWidget {
//   const SelectGroups({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final resolutionState = ref.watch(addResolutionProvider);
//     // ignore: discarded_futures
//     final groupListFuture = useMemoized(() => getGroupList(ref));
//     final groupListSnapshot = useFuture(groupListFuture);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: DropDownMultiSelect<String>(
//         onChanged: (currentSelected) {
//           final groupList = groupListSnapshot.data
//               ?.where((element) => currentSelected.contains(element.groupName))
//               .toList();
//           ref
//               .read(addResolutionProvider.notifier)
//               .changeGroupList(groupList ?? []);
//         },
//         options: groupListSnapshot.data?.map((e) => e.groupName).toList() ??
//             ['그룹을 불러오는 중입니다.'],
//         selectedValues: (resolutionState.shareGroupEntityList ?? [])
//             .map((e) => e.groupName)
//             .toList(),
//         whenEmpty: '그룹을 선택해주세요.',
//         // 스타일링을 위한 코드
//         selected_values_style: const TextStyle(
//             color: CustomColors.whBlack,
//             fontSize: 16.0,
//             fontWeight: FontWeight.w500),
//         decoration: InputDecoration(
//           fillColor: CustomColors.whYellow,
//           // 배경 색상
//           filled: true,
//           contentPadding: const EdgeInsets.all(10),
//           // 패딩
//           border: OutlineInputBorder(
//             // 테두리 설정
//             borderRadius: BorderRadius.circular(36), // 둥근 테두리
//             borderSide: const BorderSide(
//               color: CustomColors.whYellow, // 테두리 색상
//               width: 2, // 테두리 두께
//             ),
//           ),
//           // 선택된 아이템의 스타일 변경 (옵션)
//           labelStyle: const TextStyle(
//             color: CustomColors.whWhite, // 레이블 글자 색상
//             fontWeight: FontWeight.bold, // 레이블 글자 굵기
//           ),
//         ),
//       ),
//     );
//   }
// }

EitherFuture<List<EitherFuture<UserDataEntity>>> getFriendList(WidgetRef ref) {
  return ref.read(getFriendListUseCaseProvider)();
}

Future<List<GroupEntity>> getGroupList(WidgetRef ref) {
  return ref.read(getGroupListUseCaseProvider)(NoParams()).then(
    (result) {
      return result.fold((failure) {
        return [];
      }, (success) {
        return success;
      });
    },
  );
}
