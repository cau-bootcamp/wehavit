import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/group_list/group_list_cell_model_provider.dart';

class DoneCreatingGroupView extends ConsumerWidget {
  const DoneCreatingGroupView({super.key, required this.groupEntity});

  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: CustomColors.whDarkBlack,
        appBar: WehavitAppBar(
          titleLabel: '그룹 만들기 완료',
          trailingTitle: '닫기',
          trailingAction: () async {
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
                    GroupListCell(
                      groupEntity: groupEntity,
                      onPressed: () async {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return GradientBottomSheet(
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.80,
                                child: CreatedGroupDetailView(
                                  groupEntity: groupEntity,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      '그룹 이름으로 검색하여\n참가 요청을 보낼 수 있습니다',
                      style: context.bodyMedium,
                    ),
                    const SizedBox(
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

class CreatedGroupDetailView extends StatelessWidget {
  const CreatedGroupDetailView({super.key, required this.groupEntity});

  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      return GroupListCellContent(asyncCellModel: ref.watch(groupListCellModelProvider(groupEntity)));
                    },
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '그룹 소개',
                        style: context.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        groupEntity.groupDescription,
                        style: context.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '그룹 리더',
                        style: context.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      UserProfileCell(groupEntity.groupManagerUid, type: UserProfileCellType.normal)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '그룹 규칙',
                        style: context.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        groupEntity.groupRule,
                        style: context.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
