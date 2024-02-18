import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/presentation/common_components/colored_button.dart';
import 'package:wehavit/presentation/common_components/gradient_bottom_sheet.dart';
import 'package:wehavit/presentation/group/group.dart';

class JoinGroupView extends StatelessWidget {
  const JoinGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: AppBar(
        title: Text(
          '그룹에 참여하기',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            color: CustomColors.whWhite,
          ),
        ),
        // leadingWidth: 100,
        leading: TextButton(
          child: Text(
            '취소',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
              color: CustomColors.whWhite,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                          hintText: '그룹 코드',
                          hintStyle: TextStyle(
                            color: CustomColors.whPlaceholderGrey,
                          ),
                        ),
                      ),
                      Visibility(
                        replacement: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close,
                            size: 24,
                            color: CustomColors.whWhite,
                          ),
                        ),
                        visible: true,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.copy,
                            size: 20,
                            color: CustomColors.whWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 28,
                    color: CustomColors.whWhite,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              child: GroupListViewCellWidget(
                cellModel: GroupListViewCellWidgetModel.dummyModel,
              ),
              onTapUp: (details) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return GradientBottomSheet(
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.80,
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GroupListViewCellContentWidget(
                                        cellModel: GroupListViewCellWidgetModel
                                            .dummyModel,
                                      ),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '그룹 소개',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                                color: CustomColors.whWhite,
                                              ),
                                            ),
                                            Text(
                                              '그룹 소개가 이렇게 나옵니다. 호후',
                                              style: TextStyle(
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
                                            Text(
                                              '그룹 리더',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                                color: CustomColors.whWhite,
                                              ),
                                            ),
                                            Text(
                                              '그룹 리더가 이렇게 보여집니다',
                                              style: TextStyle(
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
                                            Text(
                                              '그룹 규칙',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                                color: CustomColors.whWhite,
                                              ),
                                            ),
                                            Text(
                                              '그룹 규칙이 이렇게 작성됩니다.',
                                              style: TextStyle(
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
                            Visibility(
                              visible: false,
                              replacement: ColoredButton(
                                buttonTitle: '참여 신청 완료',
                                foregroundColor: CustomColors.whWhite,
                                backgroundColor:
                                    const Color.fromARGB(255, 120, 86, 0),
                                onPressed: () {},
                              ),
                              child: ColoredButton(
                                buttonTitle: '참여 신청하기',
                                foregroundColor: CustomColors.whBlack,
                                backgroundColor: CustomColors.whYellow,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
