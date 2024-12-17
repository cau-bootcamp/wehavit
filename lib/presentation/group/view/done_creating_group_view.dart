import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/dependency/domain/domain.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class DoneCreatingGroupView extends ConsumerWidget {
  const DoneCreatingGroupView({super.key, required this.groupEntity});

  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: discarded_futures
    final futureUserModel = ref.read(getMyUserDataUsecaseProvider)();

    return PopScope(
      canPop: false,
      // onWillPop: () async {
      //   return false;
      // },
      child: Scaffold(
        backgroundColor: CustomColors.whDarkBlack,
        appBar: WehavitAppBar(
          title: '그룹 만들기 완료',
          trailingTitle: '닫기',
          trailingAction: () async {
            ref.read(groupViewModelProvider.notifier).loadMyGroupCellList();

            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
        ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.whGrey,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(64),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  groupEntity.groupName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w700,
                                    color: CustomColors.pointColorList[groupEntity.groupColor],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '그룹 소개',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.whWhite,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Text(
                                          groupEntity.groupDescription ?? '',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300,
                                            color: CustomColors.whWhite,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '그룹 리더',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.whWhite,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 16.0,
                                          top: 8.0,
                                        ),
                                        child: FriendListCellWidget(
                                          futureUserEntity: futureUserModel,
                                          cellState: FriendListCellState.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '그룹 규칙',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.whWhite,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Text(
                                          groupEntity.groupRule ?? '',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300,
                                            color: CustomColors.whWhite,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      '그룹 이름으로 검색하여\n참가 요청을 보낼 수 있습니다',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whWhite,
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),

                    // 이후에 링크로 초대 신청하기 기능이 나오면,
                    // 바로 복사할 때 여기 버튼을 활용해주기!

                    // WideColoredButton(
                    //   buttonTitle: '그룹 코드 복사하기',
                    //   foregroundColor: CustomColors.whBlack,
                    //   backgroundColor: CustomColors.whYellow,
                    //   onPressed: () async {
                    //     Clipboard.setData(
                    //       ClipboardData(text: groupEntity.groupId),
                    //     );

                    //     showToastMessage(
                    //       context,
                    //       text: '복사된 그룹 코드를 공유해보세요',
                    //       icon: const Icon(
                    //         Icons.check_circle,
                    //         color: Colors.green,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
