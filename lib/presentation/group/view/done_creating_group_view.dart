import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/colored_button.dart';

class DoneCreatingGroupView extends StatelessWidget {
  DoneCreatingGroupView({super.key, required this.groupEntity});

  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: CustomColors.whDarkBlack,
        appBar: AppBar(
          title: const Text(
            '그룹 만들기 완료',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
              color: CustomColors.whWhite,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                '닫기',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.whWhite,
                ),
              ),
              onPressed: () {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
            ),
          ],
          backgroundColor: Colors.transparent,
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
                                    color: PointColors
                                        .colorList[groupEntity.groupColor],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '그룹 소개',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors.whWhite,
                                        ),
                                      ),
                                      Text(
                                        groupEntity.groupDescription ?? '',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300,
                                          color: CustomColors.whWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '그룹 리더',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors.whWhite,
                                        ),
                                      ),
                                      Text(
                                        groupEntity.groupManagerUid,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300,
                                          color: CustomColors.whWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '그룹 규칙',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors.whWhite,
                                        ),
                                      ),
                                      Text(
                                        groupEntity.groupRule ?? '',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300,
                                          color: CustomColors.whWhite,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ColoredButton(
                  buttonTitle: '그룹 코드 복사하기',
                  foregroundColor: CustomColors.whBlack,
                  backgroundColor: CustomColors.whYellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
